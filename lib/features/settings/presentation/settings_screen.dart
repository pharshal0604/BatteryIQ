import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Notifications',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Vehicles near EOL (SoH ≤ 80%)'),
            subtitle: const Text('Get alerts when any vehicle is close to end-of-life capacity.'),
            value: true, // TODO: wire to state later
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: const Text('Vehicles needing attention soon'),
            subtitle: const Text('Notify when health drops into the “Monitor” band.'),
            value: true,
            onChanged: (value) {},
          ),
          const Divider(height: 32),

          Text(
            'Health thresholds',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const ListTile(
            title: Text('Healthy SoH ≥ 80%'),
            subtitle: Text('Matches warranty EOL definition at 80% capacity.'),
          ),
          const ListTile(
            title: Text('Near EOL when SoH ≤ 80%'),
            subtitle: Text('Vehicles below this band are flagged as “Near EOL”.'),
          ),

          const Divider(height: 32),

          Text(
            'Driving impact sensitivity',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const ListTile(
            title: Text('Medium'),
            subtitle: Text('Balance between too few and too many driving stress alerts.'),
          ),
        ],
      ),
    );
  }
}
