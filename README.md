<div align="center">

# ⚡ EV Fleet Health

### Real-time Battery Health Monitoring for EV Fleets

[![Flutter](https://img.shields.io/badge/Flutter-3.38+-02569B?style=flat&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=flat&logo=dart)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-2.x-00BCD4?style=flat)](https://riverpod.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)](https://flutter.dev)

*Built for Endurance Technologies — Hackathon 2026*

</div>

---

## 📱 Overview

**EV Fleet Health** is a cross-platform mobile app for fleet supervisors and drivers to monitor
the real-time battery health of electric vehicles. Designed for quick status checks and
actionable alerts — no heavy dashboards, no clutter.

> Target users: Fleet supervisors managing a light fleet, and drivers who need
> high-level battery health at a glance.

---

## ✨ Features

### 🏠 Fleet Dashboard
- **3 stat cards** — Healthy / Attention / Critical vehicle counts
- Fleet status banner — instant health overview
- Compact vehicle list preview — top 5 vehicles
- Pull-to-refresh with auto-polling every N seconds

### 🚗 Vehicle List
- Full searchable, filterable vehicle list
- Filter by **status** (Healthy / Attention / Critical)
- Filter by **driving stress** (Low / Medium / High)
- Real-time search by vehicle ID

### 🔋 Vehicle Detail
| Section | What You See |
|---|---|
| **Health & RUL** | Animated SoH arc circle, RUL in months + cycles, charge level, temperature |
| **Degradation Trend** | Sparkline chart with 7D / 30D / 90D / 1Y range selector |
| **Driving Stress** | Overall stress badge + 2–3 insight bullets vs fleet average |
| **Regeneration** | Used vs regenerated kWh, efficiency bar, regen ratio |

---

## 🏗️ Tech Stack

| Layer | Technology |
|---|---|
| **UI** | Flutter 3.38+ |
| **State Management** | Riverpod 2.x (AsyncNotifier) |
| **Navigation** | GoRouter |
| **HTTP Client** | Dio + Interceptors |
| **Models** | Freezed + json_serializable |
| **Fonts** | Google Fonts (Lato) |
| **Backend** | Spring Boot REST API |
| **Notifications** | flutter_local_notifications |
| **Shimmer** | shimmer package |

---

## 📁 Project Structure

