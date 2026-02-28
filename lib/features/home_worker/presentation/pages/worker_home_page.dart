import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zolver/core/routes/app_routes.dart';
import 'package:zolver/core/ui/app_list_card.dart';
import 'package:zolver/core/ui/app_metric_card.dart';
import 'package:zolver/core/ui/app_scaffold.dart';
import 'package:zolver/core/ui/app_section.dart';
import 'package:zolver/core/ui/app_settings_tile.dart';
import 'package:zolver/features/jobs/presentation/pages/job_details_page.dart';

class WorkerHomePage extends StatefulWidget {
  const WorkerHomePage({super.key});

  @override
  State<WorkerHomePage> createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _WorkerDashboardTab(),
      const _WorkerJobsTab(),
      const _WorkerEarningsTab(),
      const _WorkerProfileTab(),
    ];

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Zolver'),
        actions: [
          IconButton(
            tooltip: 'Availability',
            onPressed: () {
              Get.toNamed(Routes.settings);
            },
            icon: const Icon(Icons.event_available_outlined),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        switchInCurve: Curves.easeOut,
        child: pages[_index],
      ),
      floatingActionButton: _index == 1
          ? FloatingActionButton.extended(
              onPressed: () {
                Get.snackbar(
                  'UI-only',
                  'Use the job details screen to simulate an application.',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                );
              },
              icon: const Icon(Icons.send_rounded),
              label: const Text('Apply'),
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
            icon: Icon(Icons.work_outline_rounded),
            activeIcon: Icon(Icons.work_rounded),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.paid_outlined),
            activeIcon: Icon(Icons.paid_rounded),
            label: 'Earnings',
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

class _WorkerDashboardTab extends StatelessWidget {
  const _WorkerDashboardTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return ListView(
      children: [
        Text(
          'Good to see you',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Let’s keep your profile strong to win better jobs.',
          style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AppMetricCard(
                icon: Icons.star_rounded,
                label: 'Rating',
                value: '4.9',
                color: cs.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppMetricCard(
                icon: Icons.task_alt_rounded,
                label: 'Jobs',
                value: '23',
                color: cs.tertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppSection(
          title: 'Profile checklist',
          subtitle: 'Complete these for better visibility (UI-only).',
          child: Column(
            children: const [
              _ChecklistTile(
                title: 'Add a profile photo',
                done: false,
              ),
              SizedBox(height: 10),
              _ChecklistTile(
                title: 'Verify phone number',
                done: false,
              ),
              SizedBox(height: 10),
              _ChecklistTile(
                title: 'Add portfolio/work samples',
                done: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WorkerJobsTab extends StatelessWidget {
  const _WorkerJobsTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return ListView(
      children: [
        Text(
          'Job feed',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Browse opportunities matched to your skills.',
          style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 16),
        const _JobCard(
          title: 'Fix bathroom leak',
          subtitle: 'Budget: \$35–\$60 • 2 km away',
          tag: 'Urgent',
        ),
        const SizedBox(height: 10),
        const _JobCard(
          title: 'Install ceiling fan',
          subtitle: 'Budget: \$40–\$80 • 5 km away',
          tag: 'New',
        ),
        const SizedBox(height: 10),
        const _JobCard(
          title: 'Landing page redesign',
          subtitle: 'Budget: \$120–\$250 • Remote',
          tag: 'Remote',
        ),
      ],
    );
  }
}

class _WorkerEarningsTab extends StatelessWidget {
  const _WorkerEarningsTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return ListView(
      children: [
        Text(
          'Earnings',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'A clear overview of your income and payouts.',
          style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AppMetricCard(
                icon: Icons.account_balance_wallet_rounded,
                label: 'This month',
                value: '\$620',
                color: cs.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppMetricCard(
                icon: Icons.trending_up_rounded,
                label: 'All time',
                value: '\$3.2k',
                color: cs.tertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppSection(
          title: 'Recent payouts',
          subtitle: 'Demo items for UI completeness.',
          child: Column(
            children: const [
              _PayoutTile(amount: '\$120', date: 'Feb 18', status: 'Paid'),
              SizedBox(height: 10),
              _PayoutTile(amount: '\$85', date: 'Feb 02', status: 'Paid'),
              SizedBox(height: 10),
              _PayoutTile(amount: '\$60', date: 'Jan 22', status: 'Paid'),
            ],
          ),
        ),
      ],
    );
  }
}

class _WorkerProfileTab extends StatelessWidget {
  const _WorkerProfileTab();

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
              child: Icon(Icons.work_rounded, color: cs.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Service Provider',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Boost your profile to get more clients.',
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
          title: 'Profile',
          child: Column(
            children: [
              AppSettingsTile(
                icon: Icons.edit_outlined,
                title: 'Edit profile',
                subtitle: 'Services, skills, pricing',
                onTap: () => Get.toNamed(Routes.editProfile),
              ),
              const SizedBox(height: 10),
              AppSettingsTile(
                icon: Icons.badge_outlined,
                title: 'Verification',
                subtitle: 'Identity and trust',
                onTap: () => Get.snackbar(
                  'Coming soon',
                  'Verification will be added in the next phase.',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                ),
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

class _ChecklistTile extends StatelessWidget {
  final String title;
  final bool done;

  const _ChecklistTile({required this.title, required this.done});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onTap: () {
          Get.snackbar(
            'Coming soon',
            'Checklist actions will be enabled later.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
        },
        leading: Icon(
          done ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
          color: done ? cs.tertiary : cs.onSurfaceVariant,
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String tag;

  const _JobCard({required this.title, required this.subtitle, required this.tag});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return AppListCard(
      onTap: () {
        Get.toNamed(
          Routes.jobDetails,
          arguments: JobDetailsArgs(title: title, subtitle: subtitle, tag: tag),
        );
      },
      leading: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: cs.primary.withOpacity(0.12),
        ),
        child: Icon(Icons.work_rounded, color: cs.primary),
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
          color: cs.secondary.withOpacity(0.12),
        ),
        child: Text(
          tag,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: cs.secondary,
          ),
        ),
      ),
    );
  }
}

class _PayoutTile extends StatelessWidget {
  final String amount;
  final String date;
  final String status;

  const _PayoutTile({required this.amount, required this.date, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onTap: () {
          Get.snackbar(
            'Coming soon',
            'Payout details will open here.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
        },
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: cs.tertiary.withOpacity(0.12),
          ),
          child: Icon(Icons.payments_rounded, color: cs.tertiary),
        ),
        title: Text(
          amount,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        subtitle: Text(
          date,
          style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
        ),
        trailing: Text(
          status,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w900,
            color: cs.tertiary,
          ),
        ),
      ),
    );
  }
}

