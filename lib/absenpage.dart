import 'dart:async';

import 'package:absenku/bloc/absenPage/absenPageBloc/absen_page_bloc.dart';
import 'package:absenku/bloc/absenPage/buttonCheckOut/button_check_out_bloc.dart';
import 'package:absenku/bloc/absenPage/buttonCheckin/button_check_in_bloc.dart';
import 'package:absenku/homepage.dart';
import 'package:absenku/service/pref_handler.dart';
import 'package:absenku/utils/utils.dart';
import 'package:absenku/utils/wiget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:toastification/toastification.dart';

class Absenpage extends StatefulWidget {
  const Absenpage({super.key});

  @override
  State<Absenpage> createState() => _AbsenpageState();
}

class _AbsenpageState extends State<Absenpage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  DateFormat dateFormat = DateFormat("EEEE, dd MMMM yyyy");
  String currentAddress = "Unknown";
  String currentLatLong = "Unknown";
  double currentLat = 0;
  double currentLong = 0;
  String token = "";

  @override
  void initState() {
    super.initState();
    context.read<AbsenPageBloc>().add(GetData());
  }

  @override
  Widget build(BuildContext contextpage) {
    return Scaffold(
      // appBar: AppBar(),
      body: BlocBuilder<AbsenPageBloc, AbsenPageState>(
        builder: (context, state) {
          if (state is AbsenPageLoading) {
            return Center(
              child: Lottie.asset(
                'assets/images/loadinganimation.json',
                width: 250,
                // repeat: false,
                fit: BoxFit.fitWidth,
              ),
            );
          }
          if (state is AbsenPageSucsess) {
            currentLat = state.currentLat;
            currentLong = state.currentLong;
            currentAddress = state.currentAddress;
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.625,
                  margin: EdgeInsets.only(top: 40),

                  child: GoogleMap(
                    circles: <Circle>{
                      Circle(
                        circleId: const CircleId("circle"),
                        center: LatLng(state.currentLat, state.currentLong),
                        radius: 1,
                        fillColor: mainColor.withOpacity(0.5),
                        strokeWidth: 2,
                        strokeColor: mainColor,
                      ),
                    },
                    compassEnabled: true,
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(state.currentLat, state.currentLong),
                      zoom: 18.4746,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 48, left: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(FluentIcons.arrow_left_20_filled),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.38,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.grey,
                            // offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          SizedBox(width: 50, child: Divider(thickness: 3)),
                          SizedBox(height: 25),
                          SizedBox(
                            // decoration: BoxDecoration(
                            //   color: Colors.greenAccent,
                            // ),
                            width: 300,
                            child: Row(
                              children: [
                                Icon(Icons.location_pin, color: Colors.grey),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Your Location", style: kanit20Bold),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 300,
                            child: Text(
                              state.currentAddress,
                              textAlign: TextAlign.center,
                              style: kanit16normal,
                            ),
                          ),
                          SizedBox(height: 50),
                          BlocConsumer<ButtonCheckInBloc, ButtonCheckInState>(
                            listener: (context, state) {
                              if (state is ButtonCheckSucsess) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      insetPadding: EdgeInsets.all(20),
                                      child: Container(
                                        width: double.infinity,
                                        height: 480,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.fromLTRB(
                                          20,
                                          50,
                                          20,
                                          20,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  state.data.statusCode == 200
                                                      ? LottieBuilder.asset(
                                                        'assets/images/check.json',
                                                        width: 100,
                                                        // fit: BoxFit.cover,
                                                        repeat: false,
                                                        alignment:
                                                            Alignment.center,
                                                      )
                                                      : LottieBuilder.asset(
                                                        'assets/images/wrong.json',
                                                        width: 100,
                                                        // fit: BoxFit.cover,
                                                        repeat: false,
                                                        alignment:
                                                            Alignment.center,
                                                      ),
                                                  Text(
                                                    state.data.message
                                                        .toString(),
                                                    style: kanit20Bold,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 50),

                                            state.data.statusCode == 200
                                                ? Container(
                                                  decoration: BoxDecoration(
                                                    color: mainColor
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          16.0,
                                                        ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Detail",
                                                          style:
                                                              kanit16normalBold,
                                                        ),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              FluentIcons
                                                                  .calendar_16_filled,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              // dateFormat.format(DateTime.parse(state.data.data!.checkIn!))
                                                              "Jumat, 24 maret 2024",
                                                              style:
                                                                  kanit16normal,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              FluentIcons
                                                                  .clock_16_filled,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "08:48",
                                                              style:
                                                                  kanit16normal,
                                                            ),
                                                          ],
                                                        ),
                                                        // Text(data)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                : Container(),
                                            SizedBox(height: 50),
                                            uniButton(
                                              context,
                                              title: Text(
                                                "Tutup",
                                                style: kanit16normalBoldWhite,
                                              ),
                                              func: () {
                                                Navigator.pop(context);
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
                              if (state is ButtonCheckLoading) {
                                return Center(
                                  child: Lottie.asset(
                                    'assets/images/loadinganimation.json',
                                    width: 50,
                                    // repeat: false,
                                    fit: BoxFit.fitWidth,
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: uniButton(
                                  context,
                                  title: Text(
                                    "Absen Masuk",
                                    style: kanit16normalBoldWhite,
                                  ),
                                  func: () {
                                    context.read<ButtonCheckInBloc>().add(
                                      CheckIn(
                                        lat: currentLat,
                                        long: currentLong,
                                        addres: currentAddress,
                                        // token: token,
                                      ),
                                    );
                                  },
                                  warna: mainColor,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 30),

                          BlocConsumer<ButtonCheckOutBloc, ButtonCheckOutState>(
                            listener: (context, state) {
                              if (state is ButtonCheckOutSucsess) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      insetPadding: EdgeInsets.all(20),
                                      child: Container(
                                        width: double.infinity,
                                        height: 480,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.fromLTRB(
                                          20,
                                          50,
                                          20,
                                          20,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  state.model.statusCode == 200
                                                      ? LottieBuilder.asset(
                                                        'assets/images/check.json',
                                                        width: 100,
                                                        // fit: BoxFit.cover,
                                                        repeat: false,
                                                        alignment:
                                                            Alignment.center,
                                                      )
                                                      : LottieBuilder.asset(
                                                        'assets/images/wrong.json',
                                                        width: 100,
                                                        // fit: BoxFit.cover,
                                                        repeat: false,
                                                        alignment:
                                                            Alignment.center,
                                                      ),
                                                  Text(
                                                    state.model.message
                                                        .toString(),
                                                    style: kanit20Bold,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 50),

                                            state.model.statusCode == 200
                                                ? Container(
                                                  decoration: BoxDecoration(
                                                    color: mainColor
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          16.0,
                                                        ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Detail",
                                                          style:
                                                              kanit16normalBold,
                                                        ),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              FluentIcons
                                                                  .calendar_16_filled,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              // dateFormat.format(DateTime.parse(state.data.data!.checkIn!))
                                                              "Jumat, 24 maret 2024",
                                                              style:
                                                                  kanit16normal,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              FluentIcons
                                                                  .clock_16_filled,
                                                            ),
                                                            SizedBox(width: 10),
                                                            Text(
                                                              "08:48",
                                                              style:
                                                                  kanit16normal,
                                                            ),
                                                          ],
                                                        ),
                                                        // Text(data)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                : Container(),
                                            SizedBox(height: 50),
                                            uniButton(
                                              context,
                                              title: Text(
                                                "Tutup",
                                                style: kanit16normalBoldWhite,
                                              ),
                                              func: () {
                                                Navigator.pop(context);
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
                              if (state is ButtonCheckOutLoading) {
                                return Center(
                                  child: Lottie.asset(
                                    'assets/images/loadinganimation.json',
                                    width: 50,
                                    // repeat: false,
                                    fit: BoxFit.fitWidth,
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: uniButton(
                                  context,
                                  title: Text(
                                    "Absen Keluar",
                                    style: kanit16normalBoldWhite,
                                  ),
                                  func: () {
                                    context.read<ButtonCheckOutBloc>().add(
                                      CheckOut(
                                        lat: currentLat,
                                        long: currentLong,
                                        addres: currentAddress,
                                        currentLatLong: currentLatLong,
                                      ),
                                    );
                                  },
                                  warna: mainColor,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: Text("Failed Load Data"));
        },
      ),
    );
  }
}
