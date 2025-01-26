import 'package:get/get.dart';
import 'package:playground/app/views/admin_panel.dart';

import '../modules/Chat/bindings/chat_binding.dart';
import '../modules/Chat/views/chat_view.dart';
import '../modules/EditProfile/bindings/edit_profile_binding.dart';
import '../modules/EditProfile/views/edit_profile_view.dart';
import '../modules/FriendsProfile/bindings/friends_profile_binding.dart';
import '../modules/FriendsProfile/views/friends_profile_view.dart';
import '../modules/Main/bindings/main_binding.dart';
import '../modules/Main/views/main_view.dart';
import '../modules/Messages/bindings/messages_binding.dart';
import '../modules/Messages/views/messages_view.dart';
import '../modules/Notification/bindings/notification_binding.dart';
import '../modules/Notification/views/notification_view.dart';
import '../modules/ResetPassword/bindings/reset_password_binding.dart';
import '../modules/ResetPassword/views/reset_password_view.dart';
import '../modules/Settings/bindings/settings_binding.dart';
import '../modules/Settings/views/settings_view.dart';
import '../modules/Splash/bindings/splash_binding.dart';
import '../modules/Splash/views/splash_view.dart';
import '../modules/TournamentDetail/bindings/tournament_detail_binding.dart';
import '../modules/TournamentDetail/views/tournament_detail_view.dart';
import '../modules/TournamentStages/bindings/tournament_stages_binding.dart';
import '../modules/TournamentStages/views/tournament_stages_view.dart';
import '../modules/Verification/bindings/verification_binding.dart';
import '../modules/Verification/views/verification_view.dart';
import '../modules/Wallet/bindings/wallet_binding.dart';
import '../modules/Wallet/views/wallet_view.dart';
import '../modules/createMatch/bindings/create_match_binding.dart';
import '../modules/createMatch/views/create_match_view.dart';
import '../modules/forgetPassword/bindings/forget_password_binding.dart';
import '../modules/forgetPassword/views/forget_password_view.dart';
import '../modules/games/bindings/games_binding.dart';
import '../modules/games/views/games_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/matchDetail/bindings/match_detail_binding.dart';
import '../modules/matchDetail/views/match_detail_view.dart';
import '../modules/ranking/bindings/ranking_binding.dart';
import '../modules/ranking/views/ranking_view.dart';
import '../modules/signIn/bindings/signin_binding.dart';
import '../modules/signIn/views/signin_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SigninBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => const VerificationView(),
      binding: VerificationBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.WALLET,
      page: () => const WalletView(),
      binding: WalletBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.MESSAGES,
      page: () => const MessagesView(),
      binding: MessagesBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FRIENDS_PROFILE,
      page: () => const FriendsProfileView(),
      binding: FriendsProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.MATCH_DETAIL,
      page: () => const MatchDetailView(),
      binding: MatchDetailBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TOURNAMENT_STAGES,
      page: () => const TournamentStagesView(),
      binding: TournamentStagesBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CREATE_MATCH,
      page: () => const CreateMatchView(),
      binding: CreateMatchBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.RANKING,
      page: () => const RankingView(),
      binding: RankingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.GAMES,
      page: () => const GamesView(),
      binding: GamesBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TOURNAMENT_DETAIL,
      page: () => const TournamentDetailView(),
      binding: TournamentDetailBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
