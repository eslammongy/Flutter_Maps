import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/presentaion/screens/forget_password.dart';
import 'package:flutter_maps/presentaion/screens/lets_go.dart';
import 'package:flutter_maps/presentaion/screens/user_registration.dart';
import 'package:flutter_maps/presentaion/screens/user_sign_in.dart';
import 'package:flutter_maps/presentaion/screens/verify_user_phone.dart';
import 'package:flutter_maps/presentaion/screens/create_user_account.dart';
import 'package:flutter_maps/presentaion/screens/user_profile.dart';
import 'logic/bloc/phone_auth_bloc.dart';
import 'presentaion/screens/phone_auth.dart';
import 'presentaion/screens/splash_screen.dart';
import 'presentaion/screens/success_screen.dart';

class AppRouter {
  late FirebaseAuthAppCubit phoneAuthCubit;
  AppRouter() {
    phoneAuthCubit = FirebaseAuthAppCubit();
  }
  Route generateRoute(RouteSettings routeSettings) {
    final phoneNumber = routeSettings.arguments;
    switch (routeSettings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case userLoginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<FirebaseAuthAppCubit>.value(
                  value: phoneAuthCubit,
                  child: UserLoginScreen(),
                ));

      case userRegistrationScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<FirebaseAuthAppCubit>.value(
                  value: phoneAuthCubit,
                  child: UserRegistrationScreen(),
                ));

      case userForgetPasswordScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<FirebaseAuthAppCubit>.value(
                  value: phoneAuthCubit,
                  child: const ForgetPasswordScreen(),
                ));

      case phoneAuthScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<FirebaseAuthAppCubit>.value(
                  value: phoneAuthCubit,
                  child: PhoneAuthScreen(),
                ));

      case verifyPhoneScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<FirebaseAuthAppCubit>.value(
                  value: phoneAuthCubit,
                  child: VerifyPhoneNumber(
                    phoneNumber: phoneNumber.toString(),
                  ),
                ));

      case createAccountScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<FirebaseAuthAppCubit>.value(
                  value: phoneAuthCubit,
                  child: CreateUserAccount(
                    phoneNumber: phoneNumber.toString(),
                  ),
                ));

      case welcomeScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<FirebaseAuthAppCubit>.value(
                  value: phoneAuthCubit,
                  child: const WelcomesScreen(),
                ));

      case userProfileScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<FirebaseAuthAppCubit>.value(
                  value: phoneAuthCubit,
                  child: UserProfileScreen(),
                ));
      default:
        {
          return MaterialPageRoute(builder: (_) => const SplashScreen());
        }
    }
  }
}
