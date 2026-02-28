import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zolver/core/ui/app_scaffold.dart';

class RequestDetailsArgs {
  final String title;
  final String subtitle;
  final String status;

  const RequestDetailsArgs({
    required this.title,
    required this.subtitle,
    required this.status,
  });
}

class RequestDetailsPage extends StatelessWidget {
  const RequestDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final args = (Get.arguments is RequestDetailsArgs)
        ? Get.arguments as RequestDetailsArgs
        : const RequestDetailsArgs(
            title: 'Request',
            subtitle: '0 offers • draft',
            status: 'Draft',
          );

    return AppScaffold(
      appBar: AppBar(title: const Text('Request details')),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: cs.primary.withOpacity(0.12),
                    ),
                    child: Icon(Icons.assignment_rounded, color: cs.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          args.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          args.subtitle,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: cs.primary.withOpacity(0.10),
                    ),
                    child: Text(
                      args.status,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: cs.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Here you will see the full description of the request, attachments, and preferences once backend is wired.',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Offers',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'This section will list offers from professionals with pricing and ETA.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.schedule_rounded),
              title: const Text('Schedule'),
              subtitle:
                  const Text('Preferred time & date (placeholder content).'),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.snackbar(
                'UI-only',
                'Editing / cancelling requests will be wired later.',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              ),
              child: const Text('Edit / manage request'),
            ),
          ),
        ],
      ),
    );
  }
}

