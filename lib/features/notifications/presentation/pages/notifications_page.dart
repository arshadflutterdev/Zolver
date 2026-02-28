import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zolver/core/ui/app_scaffold.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return AppScaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        children: [
          Text(
            'Recent updates',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 10),
          _NotificationCard(
            icon: Icons.check_circle_rounded,
            color: cs.tertiary,
            title: 'Request scheduled',
            message: 'Your “Fix kitchen sink” request was scheduled.',
            time: '2h',
            unread: true,
          ),
          const SizedBox(height: 10),
          _NotificationCard(
            icon: Icons.local_offer_rounded,
            color: cs.primary,
            title: 'New offer received',
            message: 'Omar S. sent an offer on your request.',
            time: '6h',
            unread: true,
          ),
          const SizedBox(height: 10),
          _NotificationCard(
            icon: Icons.info_outline_rounded,
            color: cs.secondary,
            title: 'Tip',
            message: 'Complete your profile to get better matches.',
            time: '1d',
            unread: false,
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.done_all_rounded),
              title: Text(
                'Mark all as read',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => Get.snackbar(
                'UI-only',
                'This action will be wired once backend is integrated.',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final String time;
  final bool unread;

  const _NotificationCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.time,
    required this.unread,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Get.snackbar(
          'Coming soon',
          'Notification details will open here.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: color.withOpacity(0.12),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        Text(
                          time,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              if (unread) ...[
                const SizedBox(width: 10),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cs.primary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

