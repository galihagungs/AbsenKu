import 'package:absenku/bloc/absenPage/absenPageBloc/absen_page_bloc.dart';
import 'package:absenku/bloc/absenPage/buttonCheckOut/button_check_out_bloc.dart';
import 'package:absenku/bloc/absenPage/buttonCheckin/button_check_in_bloc.dart';
import 'package:absenku/bloc/profilebloc/profile_bloc.dart';
import 'package:absenku/bloc/userHomepage/Home/history_absen_home_bloc.dart';
import 'package:absenku/bloc/userHomepage/deleteIzin/delete_izin_bloc.dart';
import 'package:absenku/bloc/userHomepage/izin/button_izin_bloc.dart';
import 'package:absenku/bloc/userHomepage/userprofile/user_home_page_bloc.dart';
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
        BlocProvider(create: (context) => HistoryAbsenHomeBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => ButtonIzinBloc()),
        BlocProvider(create: (context) => DeleteIzinBloc()),
      ],
      child: MaterialApp(
        title: 'AbsenKu',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        ),
        home: const OnboardingPage(),
      ),
    );
  }
}
