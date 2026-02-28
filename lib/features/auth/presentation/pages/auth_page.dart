import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zolver/core/ui/app_scaffold.dart';
import 'package:zolver/core/ui/pill_toggle.dart';
import 'package:zolver/features/auth/presentation/controllers/auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final role = controller.role;
    final roleLabel = role == 'worker'
        ? 'Service Provider'
        : role == 'client'
            ? 'Service Seeker'
            : null;
    final roleIcon = role == 'worker'
        ? Icons.work_outline_rounded
        : role == 'client'
            ? Icons.search_rounded
            : null;

    return AppScaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _AuthHeader(roleLabel: roleLabel, roleIcon: roleIcon),
          const SizedBox(height: 18),
          Obx(
            () => PillToggle(
              leftLabel: 'Email',
              rightLabel: 'Phone',
              leftSelected: controller.useEmail.value,
              onLeftTap: () {
                if (!controller.useEmail.value) controller.toggleMethod();
              },
              onRightTap: () {
                if (controller.useEmail.value) controller.toggleMethod();
              },
            ),
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Obx(
                      () => controller.useEmail.value
                          ? TextFormField(
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'name@example.com',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!value.contains('@')) {
                                  return 'Enter a valid email address';
                                }
                                return null;
                              },
                            )
                          : TextFormField(
                              controller: controller.phoneController,
                              keyboardType: TextInputType.phone,
                              autofillHints: const [AutofillHints.telephoneNumber],
                              decoration: const InputDecoration(
                                labelText: 'Phone number',
                                hintText: '+1 555 0100',
                                prefixIcon: Icon(Icons.phone_outlined),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                if (value.trim().length < 7) {
                                  return 'Enter a valid phone number';
                                }
                                return null;
                              },
                            ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'By continuing, you agree to our Terms and Privacy Policy.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => ElevatedButton(
                        onPressed: controller.submit,
                        child: Text(
                          controller.useEmail.value
                              ? 'Continue with Email'
                              : 'Continue with Phone',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Get.snackbar(
                          'Coming soon',
                          'Password reset & OTP verification will be added when Firebase is wired.',
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 2),
                        );
                      },
                      child: const Text('Need help signing in?'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            child: Text(
              'Zolver • Find help. Get hired.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthHeader extends StatelessWidget {
  final String? roleLabel;
  final IconData? roleIcon;

  const _AuthHeader({this.roleLabel, this.roleIcon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    cs.primary.withOpacity(0.22),
                    cs.tertiary.withOpacity(0.16),
                  ],
                ),
              ),
              child: Icon(Icons.bolt_rounded, color: cs.primary, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sign in to continue to Zolver.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  if (roleLabel != null && roleIcon != null) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: cs.primary.withOpacity(0.10),
                        border: Border.all(color: cs.primary.withOpacity(0.25)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(roleIcon, size: 16, color: cs.primary),
                          const SizedBox(width: 6),
                          Text(
                            roleLabel!,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: cs.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
