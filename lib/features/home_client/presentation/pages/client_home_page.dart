import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zolver/core/routes/app_routes.dart';
import 'package:zolver/core/ui/app_list_card.dart';
import 'package:zolver/core/ui/app_metric_card.dart';
import 'package:zolver/core/ui/app_scaffold.dart';
import 'package:zolver/core/ui/app_section.dart';
import 'package:zolver/core/ui/app_settings_tile.dart';
import 'package:zolver/features/pro/presentation/pages/pro_profile_page.dart';
import 'package:zolver/features/requests/presentation/pages/request_details_page.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _ClientDashboardTab(),
      const _ClientExploreTab(),
      const _ClientRequestsTab(),
      const _ClientProfileTab(),
    ];

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Zolver'),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {
              Get.toNamed(Routes.notifications);
            },
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        switchInCurve: Curves.easeOut,
        child: pages[_index],
      ),
      floatingActionButton: _index == 2
          ? FloatingActionButton.extended(
              onPressed: () {
                Get.snackbar(
                  'Coming soon',
                  'Creating a service request will be enabled once backend is wired.',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                );
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('New request'),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) => setState(() => _index = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search_rounded),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long_rounded),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _ClientDashboardTab extends StatelessWidget {
  const _ClientDashboardTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ListView(
      children: [
        Text(
          'Welcome back',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Find trusted professionals and get your tasks solved.',
          style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AppMetricCard(
                icon: Icons.schedule_rounded,
                label: 'Active',
                value: '2',
                color: cs.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppMetricCard(
                icon: Icons.check_circle_rounded,
                label: 'Completed',
                value: '8',
                color: cs.tertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppSection(
          title: 'Recommended near you',
          subtitle: 'A few profiles to get you started (UI-only for now).',
          child: Column(
            children: const [
              _ProCard(
                name: 'Amina K.',
                title: 'Home cleaning • 4.9',
                tag: 'Top rated',
              ),
              SizedBox(height: 10),
              _ProCard(
                name: 'Omar S.',
                title: 'Electrician • 4.8',
                tag: 'Fast response',
              ),
              SizedBox(height: 10),
              _ProCard(
                name: 'Sarah D.',
                title: 'Graphic designer • 5.0',
                tag: 'Verified',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ClientExploreTab extends StatelessWidget {
  const _ClientExploreTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final chips = const [
      'Plumbing',
      'Cleaning',
      'Design',
      'Development',
      'Tutoring',
      'Carpentry',
    ];

    return ListView(
      children: [
        Text(
          'Explore services',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          readOnly: true,
          onTap: () {
            Get.snackbar(
              'Coming soon',
              'Search will be enabled once backend is wired.',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2),
            );
          },
          decoration: const InputDecoration(
            labelText: 'Search',
            hintText: 'Try “plumber”, “logo design”…',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final chip in chips)
              ActionChip(
                label: Text(chip),
                onPressed: () {
                  Get.snackbar(
                    'Coming soon',
                    'Category “$chip” will show available professionals.',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                  );
                },
              ),
          ],
        ),
        const SizedBox(height: 18),
        AppSection(
          title: 'Popular right now',
          subtitle: 'Curated collections (UI-only).',
          child: Column(
            children: [
              _CollectionCard(
                title: 'Same-day help',
                subtitle: 'Professionals who can start today.',
                color: cs.primary,
                icon: Icons.bolt_rounded,
              ),
              const SizedBox(height: 10),
              _CollectionCard(
                title: 'Budget-friendly',
                subtitle: 'Great value services.',
                color: cs.secondary,
                icon: Icons.savings_rounded,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ClientRequestsTab extends StatelessWidget {
  const _ClientRequestsTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return ListView(
      children: [
        Text(
          'Your requests',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Track open tasks, offers, and completed work.',
          style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 16),
        const _RequestCard(
          title: 'Fix kitchen sink',
          subtitle: '2 offers • scheduled',
          status: 'Scheduled',
        ),
        const SizedBox(height: 10),
        const _RequestCard(
          title: 'Logo design for cafe',
          subtitle: '5 offers • reviewing',
          status: 'Reviewing',
        ),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded, color: cs.onSurfaceVariant),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'These are demo items to complete the UI. Real requests will appear after backend integration.',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ClientProfileTab extends StatelessWidget {
  const _ClientProfileTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final box = GetStorage();

    return ListView(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: cs.primary.withOpacity(0.15),
              child: Icon(Icons.person_rounded, color: cs.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Client',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Complete your profile for better matches.',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppSection(
          title: 'Account',
          child: Column(
            children: [
              AppSettingsTile(
                icon: Icons.edit_outlined,
                title: 'Edit profile',
                subtitle: 'Name, location, preferences',
                onTap: () => Get.toNamed(Routes.editProfile),
              ),
              const SizedBox(height: 10),
              AppSettingsTile(
                icon: Icons.settings_outlined,
                title: 'Settings',
                subtitle: 'Notifications, privacy, language',
                onTap: () => Get.toNamed(Routes.settings),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppSection(
          title: 'Actions',
          child: Column(
            children: [
              AppSettingsTile(
                icon: Icons.swap_horiz_rounded,
                title: 'Switch role',
                subtitle: 'Go back to role selection',
                onTap: () {
                  box.remove('user_role');
                  Get.offAllNamed(Routes.roleSelection);
                },
              ),
              const SizedBox(height: 10),
              AppSettingsTile(
                icon: Icons.logout_rounded,
                title: 'Logout',
                subtitle: 'Return to onboarding',
                destructive: true,
                onTap: () {
                  box.erase();
                  Get.offAllNamed(Routes.onboarding);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProCard extends StatelessWidget {
  final String name;
  final String title;
  final String tag;

  const _ProCard({required this.name, required this.title, required this.tag});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return AppListCard(
      onTap: () {
        Get.toNamed(
          Routes.proProfile,
          arguments: ProProfileArgs(name: name, title: title, tag: tag),
        );
      },
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: cs.primary.withOpacity(0.14),
        child: Text(
          name.substring(0, 1),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: cs.primary,
          ),
        ),
      ),
      title: Text(
        name,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
      ),
      subtitle: Text(
        title,
        style:
            theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: cs.secondary.withOpacity(0.12),
        ),
        child: Text(
          tag,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: cs.secondary,
          ),
        ),
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;

  const _CollectionCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppListCard(
      onTap: () => Get.toNamed(Routes.proProfile),
      leading: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color.withOpacity(0.12),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium
            ?.copyWith(fontWeight: FontWeight.w900),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;

  const _RequestCard({
    required this.title,
    required this.subtitle,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return AppListCard(
      onTap: () {
        Get.toNamed(
          Routes.requestDetails,
          arguments:
              RequestDetailsArgs(title: title, subtitle: subtitle, status: status),
        );
      },
      leading: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: cs.primary.withOpacity(0.12),
        ),
        child: Icon(Icons.assignment_rounded, color: cs.primary),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium
            ?.copyWith(fontWeight: FontWeight.w900),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium
            ?.copyWith(color: cs.onSurfaceVariant),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: cs.primary.withOpacity(0.10),
        ),
        child: Text(
          status,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: cs.primary,
          ),
        ),
      ),
    );
  }
}

