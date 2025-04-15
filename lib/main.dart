import 'package:absenku/bloc/homepage/absenPage/absenPageBloc/absen_page_bloc.dart';
import 'package:absenku/bloc/homepage/absenPage/buttonCheckOut/button_check_out_bloc.dart';
import 'package:absenku/bloc/homepage/absenPage/buttonCheckin/button_check_in_bloc.dart';
import 'package:absenku/bloc/homepage/userHomepage/user_home_page_bloc.dart';
import 'package:absenku/onboarding.dart';
import 'package:absenku/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserHomePageBloc()),
        BlocProvider(create: (context) => AbsenPageBloc()),
        BlocProvider(create: (context) => ButtonCheckInBloc()),
        BlocProvider(create: (context) => ButtonCheckOutBloc()),
      ],
      child: MaterialApp(
        title: 'AbsenKu',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        ),
        home: const OnboardingPage(),
      ),
    );
    // return MaterialApp(
    //   title: 'AbsenKu',
    //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: mainColor)),
    //   home: const OnboardingPage(),
    // );
  }
}
