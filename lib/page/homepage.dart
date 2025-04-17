import 'package:absenku/page/absenpage.dart';
import 'package:absenku/page/allhistory.dart';
import 'package:absenku/bloc/userHomepage/Home/history_absen_home_bloc.dart';
import 'package:absenku/bloc/userHomepage/deleteIzin/delete_izin_bloc.dart';
import 'package:absenku/bloc/userHomepage/izin/button_izin_bloc.dart';
import 'package:absenku/bloc/userHomepage/userprofile/user_home_page_bloc.dart';
import 'package:absenku/page/onboarding.dart';
import 'package:absenku/page/profile.dart';
import 'package:absenku/service/UserService.dart';
import 'package:absenku/service/absenService.dart';
import 'package:absenku/service/pref_handler.dart';
import 'package:absenku/utils/toast.dart';
import 'package:absenku/utils/utils.dart';
import 'package:absenku/utils/wiget.dart';
import 'package:dio/dio.dart';
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
  TextEditingController alasanIzin = TextEditingController();
  DateFormat dateFormat = DateFormat("EEEE, dd MMMM yyyy");
  DateFormat dateFormatDay = DateFormat("EEEE");
  DateFormat dateFormatTanggal = DateFormat("dd MMMM yyyy");
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

  @override
  void initState() {
    super.initState();
    context.read<UserHomePageBloc>().add(SetupData());
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
                                      style: kanit16BoldWhite,
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
                                popAlert(
                                  context,
                                  alertText: "Apakah anda yakin ingin logout ?",
                                  funcYes: () {
                                    PreferenceHandler.removeToken();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OnboardingPage(),
                                      ),
                                    );
                                  },
                                  funcNo: () {
                                    Navigator.pop(context);
                                  },
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
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dateFormatDay.format(DateTime.now()),
                                style: kanit16BoldMain,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text(
                                  dateFormatTanggal.format(DateTime.now()),
                                  style: kanit16BoldMain,
                                ),
                              ),
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
                            Navigator.pushReplacement(
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
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Profile(),
                                    ),
                                  );
                                  break;
                                case 1:
                                  izinPOP(context);
                                  break;
                                default:
                              }
                            },
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
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "History",
                                    style: kanit20BoldMain,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Allhistory(),
                                        ),
                                      );
                                    },
                                    child: Text("Lihat Semua"),
                                  ),
                                ),
                              ),
                            ],
                          ),

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
                                        margin: EdgeInsets.only(bottom: 15),
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
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  16.0,
                                                ),
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
                                                      style: kanit16Bold,
                                                    ),
                                                    Text(
                                                      state
                                                          .data
                                                          .listdata![index]
                                                          .status
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: kanit16Bold,
                                                    ),

                                                    // Text(
                                                    //   state.data.data!.id.toString(),
                                                    // ),
                                                    state
                                                                .data
                                                                .listdata![index]
                                                                .status ==
                                                            "izin"
                                                        ? Text(
                                                          state
                                                              .data
                                                              .listdata![index]
                                                              .alasanIzin
                                                              .toString(),
                                                          style: kanit16Bold,
                                                        )
                                                        : Column(
                                                          children: [
                                                            state
                                                                        .data
                                                                        .listdata![index]
                                                                        .checkIn ==
                                                                    null
                                                                ? Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 15,
                                                                      height:
                                                                          15,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              7,
                                                                            ),
                                                                        color:
                                                                            Colors.redAccent,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      "Absen Masuk",
                                                                      style:
                                                                          kanit16Bold,
                                                                    ),
                                                                  ],
                                                                )
                                                                : Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 15,
                                                                      height:
                                                                          15,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              7,
                                                                            ),
                                                                        color:
                                                                            Colors.green,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      "Absen Masuk",
                                                                      style:
                                                                          kanit16Bold,
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
                                                                      height:
                                                                          15,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              7,
                                                                            ),
                                                                        color:
                                                                            Colors.redAccent,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      "Absen Keluar",
                                                                      style:
                                                                          kanit16Bold,
                                                                    ),
                                                                  ],
                                                                )
                                                                : Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 15,
                                                                      height:
                                                                          15,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              7,
                                                                            ),
                                                                        color:
                                                                            Colors.green,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      "Absen Keluar",
                                                                      style:
                                                                          kanit16Bold,
                                                                    ),
                                                                  ],
                                                                ),
                                                          ],
                                                        ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  16.0,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      popAlert(
                                                        context,
                                                        alertText:
                                                            "Apa anda yakin menghapus absen ini?",
                                                        funcYes: () {
                                                          context
                                                              .read<
                                                                DeleteIzinBloc
                                                              >()
                                                              .add(
                                                                DeleteIzin(
                                                                  idAbsen: int.parse(
                                                                    state
                                                                        .data
                                                                        .listdata![index]
                                                                        .id
                                                                        .toString(),
                                                                  ),
                                                                ),
                                                              );

                                                          // showToast(),
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                        },
                                                        funcNo: () {
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: Icon(
                                                      FluentIcons
                                                          .delete_20_filled,
                                                      color: Colors.redAccent,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            BlocListener<
                                              DeleteIzinBloc,
                                              DeleteIzinState
                                            >(
                                              listener: (context, state) {
                                                if (state
                                                    is DeleteIzinLoading) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (
                                                      BuildContext context,
                                                    ) {
                                                      return Dialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        insetPadding:
                                                            EdgeInsets.all(20),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 320,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  15,
                                                                ),
                                                            color: Colors.white,
                                                          ),
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                20,
                                                                50,
                                                                20,
                                                                20,
                                                              ),
                                                          child: Center(
                                                            child: Lottie.asset(
                                                              'assets/images/loadinganimation.json',
                                                              width: 200,
                                                              repeat: false,
                                                              fit:
                                                                  BoxFit
                                                                      .fitWidth,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                } else if (state
                                                    is DeleteIzinSuccess) {
                                                  Navigator.pop(context);
                                                  context
                                                      .read<
                                                        HistoryAbsenHomeBloc
                                                      >()
                                                      .add(GetData());
                                                }
                                              },
                                              child: Container(),
                                            ),
                                          ],
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

  Future<dynamic> izinPOP(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/agreement.png", width: 40),
                    SizedBox(width: 10),
                    Text("Izin", style: kanit20BoldMain),
                  ],
                ),
                SizedBox(height: 20),
                Text("Alasan Izin", style: kanit16BoldMain),
                SizedBox(height: 10),
                TextField(
                  controller: alasanIzin,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.grey.shade500,
                      ),
                    ),

                    hintStyle: kanit16normal,
                    hintText: "Alasan",
                  ),
                ),
                SizedBox(height: 25),
                BlocConsumer<ButtonIzinBloc, ButtonIzinState>(
                  listener: (context, state) {
                    if (state is ButtonIzinSuccses) {
                      alasanIzin.clear();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.all(20),
                            child: Container(
                              width: double.infinity,
                              height: 330,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                              child: Column(
                                children: [
                                  state.absenData.statusCode == 200
                                      ? Lottie.asset(
                                        'assets/images/check.json',
                                        width: 100,
                                        repeat: false,
                                        fit: BoxFit.fitWidth,
                                      )
                                      : Lottie.asset(
                                        'assets/images/alert.json',
                                        width: 100,
                                        repeat: false,
                                        fit: BoxFit.fitWidth,
                                      ),
                                  SizedBox(height: 15),
                                  Text(
                                    state.absenData.message.toString(),
                                    textAlign: TextAlign.center,
                                    style: kanit20Bold,
                                  ),
                                  SizedBox(height: 50),
                                  uniButton(
                                    context,
                                    title: Text(
                                      "OK",
                                      style: kanit16normalWhite,
                                    ),
                                    func: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      context.read<HistoryAbsenHomeBloc>().add(
                                        GetData(),
                                      );
                                    },
                                    warna: mainColor,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ButtonIzinLoading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/images/loadinganimation.json',
                          width: 100,
                          repeat: false,
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    }
                    return uniButton(
                      context,
                      title: Text("Submit", style: kanit16normalWhite),
                      func: () {
                        context.read<ButtonIzinBloc>().add(
                          CommitData(alasanIzin: alasanIzin.text),
                        );
                      },
                      warna: mainColor,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> popAlert(
    BuildContext context, {
    required String alertText,
    required VoidCallback funcYes,
    required VoidCallback funcNo,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            height: 330,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              children: [
                Lottie.asset(
                  'assets/images/alert.json',
                  width: 100,
                  repeat: false,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: 15),
                Text(
                  alertText,
                  style: kanit20Bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: uniButton(
                        context,
                        title: Text("Ya", style: kanit16normalWhite),
                        func: funcYes,
                        warna: mainColor,
                      ),
                    ),
                    SizedBox(width: 25),
                    Expanded(
                      child: uniButton(
                        context,
                        title: Text("Tidak", style: kanit16normalWhite),
                        func: funcNo,
                        warna: mainColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
