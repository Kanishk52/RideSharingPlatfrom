import 'package:flutter/material.dart';
import '../../constants/routes.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Role'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRoleCard(
              context,
              'Traveler',
              Icons.person,
              Routes.travelerHome,
            ),
            const SizedBox(height: 16),
            _buildRoleCard(
              context,
              'Companion',
              Icons.supervisor_account,
              Routes.companionHome,
            ),
            const SizedBox(height: 16),
            _buildRoleCard(
              context,
              'Admin',
              Icons.admin_panel_settings,
              Routes.adminDashboard,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context,
    String role,
    IconData icon,
    String route,
  ) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushReplacementNamed(context, route),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 48),
              const SizedBox(height: 8),
              Text(
                role,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}