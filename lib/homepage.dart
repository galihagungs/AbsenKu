import 'package:absenku/absenpage.dart';
import 'package:absenku/bloc/userHomepage/historyHome/history_absen_home_bloc.dart';
import 'package:absenku/bloc/userHomepage/userprofile/user_home_page_bloc.dart';
import 'package:absenku/onboarding.dart';
import 'package:absenku/service/UserService.dart';
import 'package:absenku/service/absenService.dart';
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
  List<Map<String, dynamic>> menuList = [
    {
      "name": "Profile",
      "icon": Icon(FluentIcons.person_20_filled, color: mainColor),
    },
    {
      "name": "Izin",
      "icon": Icon(FluentIcons.calendar_agenda_20_filled, color: mainColor),
    },
    {
      "name": "Kalender",
      "icon": Icon(FluentIcons.calendar_20_filled, color: mainColor),
    },
  ];
  // List iconList = ["Profile", "Izin", "Kalender"];

  @override
  void initState() {
    super.initState();
    context.read<UserHomePageBloc>().add(GetUser());
    context.read<HistoryAbsenHomeBloc>().add(GetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Color(0xff4266b9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
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
                                      state.data.data?.name.toString() ??
                                          "User",
                                      style: kanit16normalBoldWhite,
                                    ),
                                    Text(
                                      state.data.data?.email.toString() ??
                                          "User",
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
                              MaterialPageRoute(
                                builder: (context) => Absenpage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 25),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: menuList.length,
                        scrollDirection: Axis.horizontal,
                        itemExtent: 120,

                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Column(
                                children: [
                                  menuList[index]['icon'],
                                  Text(
                                    menuList[index]['name'].toString(),
                                    style: kanit16BoldMain,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("History", style: kanit20BoldMain),
                          ),
                          // Text(DateTime.now().toString()),
                          // Text(
                          //   DateTime.now().add(Duration(days: -1)).toString(),
                          // ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     Absenservice().getHistoryHome();
                          //   },
                          //   child: Text("Test"),
                          // ),
                          BlocBuilder<
                            HistoryAbsenHomeBloc,
                            HistoryAbsenHomeState
                          >(
                            builder: (context, state) {
                              if (state is HistoryAbsenHomeLoading) {
                                return Center(
                                  child: Lottie.asset(
                                    'assets/images/loadinganimation.json',
                                    width: 120,
                                    // repeat: false,
                                    fit: BoxFit.fitWidth,
                                  ),
                                );
                              } else if (state is HistoryAbsenHomeSuccess) {
                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: state.data.listdata!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 5,
                                              offset: Offset(1, 1),
                                            ),
                                          ],
                                        ),
                                        width: double.infinity,
                                        height: 130,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                dateFormat.format(
                                                  DateTime.parse(
                                                    state
                                                        .data
                                                        .listdata![index]
                                                        .checkIn!,
                                                  ),
                                                ),
                                                style: kanit16normalBold,
                                              ),
                                              Text(
                                                state
                                                    .data
                                                    .listdata![index]
                                                    .status
                                                    .toString()
                                                    .toUpperCase(),
                                                style: kanit16normalBold,
                                              ),

                                              state
                                                          .data
                                                          .listdata![index]
                                                          .checkIn ==
                                                      null
                                                  ? Row(
                                                    children: [
                                                      Container(
                                                        width: 15,
                                                        height: 15,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                7,
                                                              ),
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        "Absen Masuk",
                                                        style:
                                                            kanit16normalBold,
                                                      ),
                                                    ],
                                                  )
                                                  : Row(
                                                    children: [
                                                      Container(
                                                        width: 15,
                                                        height: 15,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                7,
                                                              ),
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        "Absen Masuk",
                                                        style:
                                                            kanit16normalBold,
                                                      ),
                                                    ],
                                                  ),
                                              state
                                                          .data
                                                          .listdata![index]
                                                          .checkOut ==
                                                      null
                                                  ? Row(
                                                    children: [
                                                      Container(
                                                        width: 15,
                                                        height: 15,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                7,
                                                              ),
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        "Absen Keluar",
                                                        style:
                                                            kanit16normalBold,
                                                      ),
                                                    ],
                                                  )
                                                  : Row(
                                                    children: [
                                                      Container(
                                                        width: 15,
                                                        height: 15,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                7,
                                                              ),
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        "Absen Keluar",
                                                        style:
                                                            kanit16normalBold,
                                                      ),
                                                    ],
                                                  ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return Center(
                                child: Text("Failed to load data history"),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
