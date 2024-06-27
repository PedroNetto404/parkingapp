import 'package:get/get.dart';
import 'package:parkingapp/views/sign_up_view.dart';
import '../views/customer/home_view.dart';
import '../views/sign_in_view.dart';

class AppRoutes {
  static const initial = '/';
  static const signIn = '/signin';
  static const signUp = '/signup';
  static const customerHome = '/customer_home';
  static const profile = '/profile';

  static final routes = [
    GetPage(name: initial, page: () => const SignInView()),
    GetPage(name: signIn, page: () => const SignInView()),
    GetPage(name: signUp, page: () => const SignUpView(isGoogleSignUp: false)),
    GetPage(name: customerHome, page: () => const CustomerHomeView()),
  ];
}
