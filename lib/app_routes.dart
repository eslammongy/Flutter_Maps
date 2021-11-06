import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/logic/cubit/phone_auth_cubit.dart';
import 'package:flutter_maps/presentaion/screens/Verify_phone_number.dart';
import 'package:flutter_maps/presentaion/screens/create_user_account.dart';
import 'package:flutter_maps/presentaion/screens/map_screen.dart';
import 'package:flutter_maps/presentaion/screens/phone_auth.dart';
import 'package:flutter_maps/presentaion/screens/splash_screen.dart';
import 'package:flutter_maps/presentaion/screens/success_screen.dart';

class AppRouter {
  PhoneAuthCubit phoneAuthCubit;
  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }
  Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case spalshScreen:
        return MaterialPageRoute(builder: (_) => SpalshScreen());

      case phoneAuthScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PhoneAuthCubit>.value(
                  value: phoneAuthCubit,
                  child: PhoneAuthScreen(),
                ));

      case verifyPhoneScreen:
        final phoneNumber = routeSettings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PhoneAuthCubit>.value(
                  value: phoneAuthCubit,
                  child: VerifyPhoneNumber(
                    phoneNumber: phoneNumber,
                  ),
                ));

      case createAccountScreen:
        return MaterialPageRoute(builder: (_) => CreateUserAccount());

      case wellDoneScreen:
        return MaterialPageRoute(builder: (_) => SuccessScreen());

      case googleMapsScreen:
        return MaterialPageRoute(builder: (_) => MapsScreen());
    }
    return MaterialPageRoute(builder: (_) => SpalshScreen());
  }
}
