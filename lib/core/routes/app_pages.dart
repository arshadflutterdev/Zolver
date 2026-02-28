import 'package:get/get.dart';
import 'package:zolver/core/routes/app_routes.dart';
import 'package:zolver/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:zolver/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:zolver/features/auth/domain/usecases/login_with_email.dart';
import 'package:zolver/features/auth/domain/usecases/login_with_phone.dart';
import 'package:zolver/features/auth/presentation/controllers/auth_controller.dart';
import 'package:zolver/features/auth/presentation/pages/auth_page.dart';
import 'package:zolver/features/home_client/presentation/pages/client_home_page.dart';
import 'package:zolver/features/home_worker/presentation/pages/worker_home_page.dart';
import 'package:zolver/features/jobs/presentation/pages/job_details_page.dart';
import 'package:zolver/features/notifications/presentation/pages/notifications_page.dart';
import 'package:zolver/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:zolver/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:zolver/features/pro/presentation/pages/pro_profile_page.dart';
import 'package:zolver/features/requests/presentation/pages/request_details_page.dart';
import 'package:zolver/features/role_selection/presentation/pages/role_selection_page.dart';
import 'package:zolver/features/settings/presentation/pages/settings_page.dart';

class AppPages {
  static const String initial = Routes.onboarding;

  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<OnboardingPage>(
      name: Routes.onboarding,
      page: OnboardingPage.new,
    ),
    GetPage<RoleSelectionPage>(
      name: Routes.roleSelection,
      page: RoleSelectionPage.new,
    ),
    GetPage<AuthPage>(
      name: Routes.auth,
      page: AuthPage.new,
      binding: BindingsBuilder(() {
        final remote = AuthRemoteDataSourceImpl();
        final repository = AuthRepositoryImpl(remote);
        final loginWithEmail = LoginWithEmail(repository);
        final loginWithPhone = LoginWithPhone(repository);
        Get.put<AuthController>(AuthController(loginWithEmail, loginWithPhone));
      }),
    ),
    GetPage<WorkerHomePage>(
      name: Routes.workerHome,
      page: WorkerHomePage.new,
    ),
    GetPage<ClientHomePage>(
      name: Routes.clientHome,
      page: ClientHomePage.new,
    ),
    GetPage<NotificationsPage>(
      name: Routes.notifications,
      page: NotificationsPage.new,
    ),
    GetPage<SettingsPage>(
      name: Routes.settings,
      page: SettingsPage.new,
    ),
    GetPage<EditProfilePage>(
      name: Routes.editProfile,
      page: EditProfilePage.new,
    ),
    GetPage<ProProfilePage>(
      name: Routes.proProfile,
      page: ProProfilePage.new,
    ),
    GetPage<JobDetailsPage>(
      name: Routes.jobDetails,
      page: JobDetailsPage.new,
    ),
    GetPage<RequestDetailsPage>(
      name: Routes.requestDetails,
      page: RequestDetailsPage.new,
    ),
  ];
}

