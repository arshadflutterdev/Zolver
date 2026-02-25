import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zolver/core/routes/app_routes.dart';

enum UserRole {
  worker,
  client,
}

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  void _onRoleSelected(BuildContext context, UserRole role) {
    final roleKey = role == UserRole.worker ? 'worker' : 'client';

    Get.toNamed(
      Routes.auth,
      arguments: roleKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your role'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Who are you on Zolver?',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Select the option that best describes you. You can always refine details later.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _RoleCard(
              title: 'I want to work',
              subtitle: 'Service Provider (Worker)',
              icon: Icons.work,
              color: colorScheme.primary,
              onTap: () => _onRoleSelected(context, UserRole.worker),
            ),
            const SizedBox(height: 20),
            _RoleCard(
              title: 'I want to find a professional',
              subtitle: 'Service Seeker (Client)',
              icon: Icons.search,
              color: colorScheme.secondary,
              onTap: () => _onRoleSelected(context, UserRole.client),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color.withOpacity(0.06),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color.withOpacity(0.15),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

