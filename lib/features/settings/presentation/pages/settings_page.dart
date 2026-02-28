import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zolver/core/ui/app_scaffold.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final box = GetStorage();

    ThemeMode currentMode() {
      final stored = box.read<String>('theme_mode') ?? 'system';
      return switch (stored) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
    }

    String modeLabel(ThemeMode mode) => switch (mode) {
          ThemeMode.light => 'Light',
          ThemeMode.dark => 'Dark',
          _ => 'System',
        };

    void setMode(ThemeMode mode) {
      final value = switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        _ => 'system',
      };
      box.write('theme_mode', value);
      Get.changeThemeMode(mode);
      Get.snackbar(
        'Theme updated',
        'Now using ${modeLabel(mode)} mode.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }

    return AppScaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: cs.primary.withOpacity(0.12),
                    ),
                    child: Icon(Icons.palette_outlined, color: cs.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Appearance',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Choose light, dark, or system theme.',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                _RadioTile(
                  title: 'System',
                  subtitle: 'Matches your device setting',
                  value: ThemeMode.system,
                  groupValue: currentMode(),
                  onChanged: setMode,
                ),
                const Divider(height: 1),
                _RadioTile(
                  title: 'Light',
                  subtitle: 'Bright and clean',
                  value: ThemeMode.light,
                  groupValue: currentMode(),
                  onChanged: setMode,
                ),
                const Divider(height: 1),
                _RadioTile(
                  title: 'Dark',
                  subtitle: 'Easy on the eyes',
                  value: ThemeMode.dark,
                  groupValue: currentMode(),
                  onChanged: setMode,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language_outlined),
                  title: Text(
                    'Language',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  subtitle: Text(
                    'English (coming soon)',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => Get.snackbar(
                    'Coming soon',
                    'Language switching will be added in the next phase.',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: Text(
                    'Privacy',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  subtitle: Text(
                    'Permissions & visibility (coming soon)',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => Get.snackbar(
                    'Coming soon',
                    'Privacy controls will be added later.',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: Text(
                    'About',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  subtitle: Text(
                    'Zolver v1.0 (UI phase)',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  onTap: () => showAboutDialog(
                    context: context,
                    applicationName: 'Zolver',
                    applicationVersion: '1.0.0',
                    children: const [
                      Text(
                        'This build focuses on UI/UX. Backend/Firebase integration comes next.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RadioTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final ThemeMode value;
  final ThemeMode groupValue;
  final ValueChanged<ThemeMode> onChanged;

  const _RadioTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return RadioListTile<ThemeMode>(
      value: value,
      groupValue: groupValue,
      onChanged: (v) {
        if (v == null) return;
        onChanged(v);
      },
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
      ),
    );
  }
}

