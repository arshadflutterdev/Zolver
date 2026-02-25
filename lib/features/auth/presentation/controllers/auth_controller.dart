import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zolver/core/routes/app_routes.dart';
import 'package:zolver/features/auth/domain/usecases/login_with_email.dart';
import 'package:zolver/features/auth/domain/usecases/login_with_phone.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final RxBool useEmail = true.obs;

  final GetStorage _box = GetStorage();
  String? role;
  final LoginWithEmail _loginWithEmail;
  final LoginWithPhone _loginWithPhone;

  AuthController(this._loginWithEmail, this._loginWithPhone);

  @override
  void onInit() {
    super.onInit();
    role = Get.arguments as String?;
    if (role != null) {
      _box.write('user_role', role);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void toggleMethod() {
    useEmail.toggle();
  }

  void submit() {
    final form = formKey.currentState;
    if (form == null || !form.validate()) return;

    final currentRole = role;
    if (currentRole == null) {
      Get.snackbar(
        'Missing role',
        'No role selected. Please go back and choose a role.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final String identifier = useEmail.value
        ? emailController.text.trim()
        : phoneController.text.trim();

    if (useEmail.value) {
      _loginWithEmail(email: identifier, role: currentRole).then((user) {
        final roleLabel = user.role == 'worker'
            ? 'Service Provider'
            : user.role == 'client'
                ? 'Service Seeker'
                : 'User';

        Get.snackbar(
          'Auth placeholder',
          'Auth for $roleLabel using $identifier.\nBackend/Firebase will be wired in the next phase.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );

        if (user.role == 'worker') {
          Get.offAllNamed(Routes.workerHome);
        } else if (user.role == 'client') {
          Get.offAllNamed(Routes.clientHome);
        }
      });
    } else {
      _loginWithPhone(phone: identifier, role: currentRole).then((user) {
        final roleLabel = user.role == 'worker'
            ? 'Service Provider'
            : user.role == 'client'
                ? 'Service Seeker'
                : 'User';

        Get.snackbar(
          'Auth placeholder',
          'Auth for $roleLabel using $identifier.\nBackend/Firebase will be wired in the next phase.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );

        if (user.role == 'worker') {
          Get.offAllNamed(Routes.workerHome);
        } else if (user.role == 'client') {
          Get.offAllNamed(Routes.clientHome);
        }
      });
    }
  }
}

