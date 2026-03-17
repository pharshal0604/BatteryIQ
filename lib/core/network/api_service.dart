// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:ev_fleet_app/core/config/env.dart';
import 'package:ev_fleet_app/core/network/api_client.dart';
import 'package:ev_fleet_app/core/network/api_endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Centralized API service — single place for ALL HTTP calls
/// Injected into every repository via Riverpod
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(ref.watch(dioProvider));
});

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  // ==========================================================================
  // Fleet Summary
  // ==========================================================================

  /// GET /fleet/summary
  /// Returns raw map → parsed by FleetSummaryModel in repository
  Future<Map<String, dynamic>> getFleetSummary() async {
    return await _get(ApiEndpoints.fleetSummary);
  }

  // ==========================================================================
  // Vehicle List
  // ==========================================================================

  /// GET /fleet/vehicles
  /// Optional filters: status, stress level, search query
  Future<List<dynamic>> getVehicleList({
    String? status,
    String? stress,
    String? search,
  }) async {
    final params = <String, dynamic>{};

    if (status != null && status != 'ALL') params['status'] = status;
    if (stress != null && stress != 'ALL')  params['stress'] = stress;
    if (search != null && search.isNotEmpty) params['search'] = search;

    return await _getList(
      ApiEndpoints.vehicleList,
      queryParameters: params.isEmpty ? null : params,
    );
  }

  // ==========================================================================
  // Vehicle Detail
  // ==========================================================================

  /// GET /vehicle/{id}/detail
  Future<Map<String, dynamic>> getVehicleDetail(String vehicleId) async {
    return await _get(ApiEndpoints.vehicleDetail(vehicleId));
  }

  /// GET /vehicle/{id}/trend?range=30D
  Future<List<dynamic>> getVehicleTrend(
    String vehicleId, {
    String range = '30D',
  }) async {
    return await _getList(
      ApiEndpoints.vehicleTrend(vehicleId),
      queryParameters: {'range': range},
    );
  }

  /// GET /vehicle/{id}/stress
  Future<List<dynamic>> getVehicleStress(String vehicleId) async {
    return await _getList(ApiEndpoints.vehicleStress(vehicleId));
  }

  /// GET /vehicle/{id}/regen
  Future<Map<String, dynamic>> getVehicleRegen(String vehicleId) async {
    return await _get(ApiEndpoints.vehicleRegen(vehicleId));
  }

  /// GET /vehicle/{id}/alerts
  Future<List<dynamic>> getVehicleAlerts(String vehicleId) async {
    return await _getList(ApiEndpoints.vehicleAlerts(vehicleId));
  }

  // ==========================================================================
  // Fleet Alerts
  // ==========================================================================

  /// GET /fleet/alerts
  /// Optional severity filter: ALL / WARNING / CRITICAL
  Future<List<dynamic>> getFleetAlerts({String? severity}) async {
    final params = <String, dynamic>{};
    if (severity != null && severity != 'ALL') {
      params['severity'] = severity;
    }
    return await _getList(
      ApiEndpoints.fleetAlerts,
      queryParameters: params.isEmpty ? null : params,
    );
  }

  // ==========================================================================
  // Private HTTP Helpers
  // ==========================================================================

  /// Handles GET → Map response
  Future<Map<String, dynamic>> _get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return _parseMap(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Handles GET → List response
  Future<List<dynamic>> _getList(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return _parseList(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ==========================================================================
  // Response Parsers
  // ==========================================================================

  Map<String, dynamic> _parseMap(Response response) {
    final data = response.data;

    if (data is Map<String, dynamic>) return data;

    // Spring Boot sometimes wraps in { data: {...} }
    if (data is Map && data.containsKey('data')) {
      return data['data'] as Map<String, dynamic>;
    }

    throw ApiException(
      code: response.statusCode ?? 0,
      message: 'Unexpected response format from server.',
    );
  }

  List<dynamic> _parseList(Response response) {
    final data = response.data;

    if (data is List) return data;

    // Spring Boot sometimes wraps in { data: [...] }
    if (data is Map && data.containsKey('data')) {
      return data['data'] as List<dynamic>;
    }

    throw ApiException(
      code: response.statusCode ?? 0,
      message: 'Unexpected list response format from server.',
    );
  }

  // ==========================================================================
  // Error Handler
  // ==========================================================================

  ApiException _handleError(DioException e) {
    // Already normalized by ApiClient interceptor
    if (e.error is ApiException) return e.error as ApiException;

    if (EnvConfig.isDebugMode) {
      print('[ApiService] Unhandled DioException: ${e.message}');
    }

    return ApiException(
      code: e.response?.statusCode ?? 0,
      message: e.message ?? 'Unknown error occurred.',
    );
  }
}
