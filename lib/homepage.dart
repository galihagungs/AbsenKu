import 'package:absenku/absenpage.dart';
import 'package:absenku/bloc/homepage/userHomepage/user_home_page_bloc.dart';
import 'package:absenku/onboarding.dart';
import 'package:absenku/service/UserService.dart';
import 'package:absenku/service/pref_handler.dart';
import 'package:absenku/utils/utils.dart';
import 'package:absenku/utils/wiget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:one_clock/one_clock.dart';
import 'package:shimmer/shimmer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DateFormat dateFormat = DateFormat("EEEE, dd MMMM yyyy");
  String token = "";

  @override
  void initState() {
    super.initState();
    initUser();
    context.read<UserHomePageBloc>().add(GetUser(token: token));
  }

  void initUser() async {
    // await PreferenceHandler.getId();
    token = await PreferenceHandler.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Color(0xff4266b9),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              children: [
                Image.asset('assets/images/logowhitenotext.png', width: 50),
                SizedBox(width: 10),
                Text("Absen Ku", style: kanit25boldWhite),
              ],
            ),

            SizedBox(height: 25),
            BlocBuilder<UserHomePageBloc, UserHomePageState>(
              builder: (context, state) {
                if (state is UserHomePageLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(color: bgColor),
                          ),
                        ),
                        SizedBox(width: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 200,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else if (state is UserHomePageSuccses) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                decoration: BoxDecoration(color: bgColor),
                                child: LottieBuilder.asset(
                                  'assets/images/person.json',
                                  width: 50,
                                  height: 50,
                                  // fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            SizedBox(width: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Galih Agung Sukmawan",
                                  style: kanit16normalBoldWhite,
                                ),
                                Text(
                                  "galihagung223@gmail.com",
                                  style: kanit16normalWhite,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            PreferenceHandler.removeId();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OnboardingPage(),
                              ),
                            );
                          },
                          icon: Icon(
                            FluentIcons.sign_out_20_filled,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Center(child: Text("Failed To Load Data"));
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        DigitalClock(
                          showSeconds: true,
                          datetime: DateTime.now(),
                          digitalClockTextColor: mainColor,
                          textScaleFactor: 1.3,
                          isLive: true,
                        ),
                        Text(
                          dateFormat.format(DateTime.now()),
                          style: kanit16normal,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 50),
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: uniButton(
                      context,
                      title: Text("Absen", style: kanit16BoldMain),
                      warna: Colors.white,
                      func: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Absenpage()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                UserService().getProfile(token: token);
              },
              child: Text("Get"),
            ),
          ],
        ),
      ),
    );
  }
}
