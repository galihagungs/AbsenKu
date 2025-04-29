import 'package:absenku/bloc/historypage/historyabsen/history_absen_bloc.dart';
import 'package:absenku/utils/toast.dart';
import 'package:absenku/utils/utils.dart';
import 'package:absenku/utils/wiget.dart';
import 'package:expandable/expandable.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Allhistory extends StatefulWidget {
  const Allhistory({super.key});

  @override
  State<Allhistory> createState() => _AllhistoryState();
}

class _AllhistoryState extends State<Allhistory> {
  late ExpandedTileController _controller;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateFormat dateFormat2 = DateFormat("EEEE, dd MMMM yyyy");
  DateFormat timeFormat = DateFormat("HH:mm");
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    context.read<HistoryAbsenBloc>().add(GetData());
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    startDate = args.value.startDate;
    // startDate = dateFormat.format(args.value.startDate);
    endDate = args.value.endDate ?? args.value.startDate;
    // endDate = dateFormat.format(args.value.endDate ?? args.value.startDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            FluentIcons.arrow_left_20_filled,
                            color: mainColor,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("History Absen", style: kanit20BoldMain),
                      ],
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              insetPadding: EdgeInsets.all(20),
                              child: Container(
                                width: double.infinity,
                                height: 700,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Filter Hari",
                                        style: kanit20BoldMain,
                                      ),
                                    ),
                                    Expanded(
                                      child: SfDateRangePicker(
                                        onSelectionChanged: _onSelectionChanged,
                                        backgroundColor: Colors.white,
                                        headerStyle: DateRangePickerHeaderStyle(
                                          backgroundColor: Colors.white,
                                        ),
                                        selectionMode:
                                            DateRangePickerSelectionMode.range,
                                        initialSelectedRange: PickerDateRange(
                                          DateTime.now().subtract(
                                            const Duration(days: 4),
                                          ),
                                          DateTime.now().add(
                                            const Duration(days: 3),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: uniButton(
                                            context,
                                            title: Text(
                                              "OK",
                                              style: kanit16normalWhite,
                                            ),
                                            func: () {
                                              if (startDate == endDate) {
                                                showToast(
                                                  "Pilih dua tanggal",
                                                  success: false,
                                                );
                                              }
                                              context
                                                  .read<HistoryAbsenBloc>()
                                                  .add(
                                                    FilterHistory(
                                                      startDate: startDate,
                                                      endDate: endDate,
                                                    ),
                                                  );
                                              Navigator.pop(context);
                                            },
                                            warna: mainColor,
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                        Expanded(
                                          child: uniButton(
                                            context,
                                            title: Text(
                                              "Batal",
                                              style: kanit16normalWhite,
                                            ),
                                            func: () {
                                              Navigator.pop(context);
                                            },
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
                      },
                      icon: Icon(FluentIcons.filter_20_filled),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: BlocConsumer<HistoryAbsenBloc, HistoryAbsenState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is HistoryAbsenLoading) {
                    return Lottie.asset(
                      'assets/images/loadinganimation.json',
                      width: 120,
                      // repeat: false,
                      fit: BoxFit.fitWidth,
                    );
                  } else if (state is HistoryAbsenSuccees) {
                    if (state.datalist.listdata!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LottieBuilder.asset(
                              'assets/images/empty.json',
                              width: 100,
                              height: 100,
                              // fit: BoxFit.cover,
                              alignment: Alignment.center,
                              fit: BoxFit.fitWidth,
                            ),
                            Text("Data Kosong", style: kanit20BoldMain),
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.datalist.listdata!.length,
                          itemBuilder: (context, index) {
                            return ExpandableNotifier(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    children: <Widget>[
                                      ScrollOnExpand(
                                        scrollOnExpand: true,
                                        scrollOnCollapse: false,
                                        child: ExpandablePanel(
                                          theme: const ExpandableThemeData(
                                            headerAlignment:
                                                ExpandablePanelHeaderAlignment
                                                    .center,
                                            tapBodyToCollapse: true,
                                          ),
                                          header: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  dateFormat2.format(
                                                    DateTime.parse(
                                                      state
                                                          .datalist
                                                          .listdata![index]
                                                          .checkIn
                                                          .toString(),
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 50),
                                                IconButton(
                                                  onPressed: () {
                                                    popAlert(
                                                      context,
                                                      alertText:
                                                          "Apa anda yakin menghapus absen ini?",
                                                      funcYes: () {
                                                        context
                                                            .read<
                                                              HistoryAbsenBloc
                                                            >()
                                                            .add(
                                                              DeleteIzin(
                                                                idAbsen: int.parse(
                                                                  state
                                                                      .datalist
                                                                      .listdata![index]
                                                                      .id
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            );

                                                        Navigator.pop(context);
                                                      },
                                                      funcNo: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  },
                                                  icon: Icon(
                                                    FluentIcons
                                                        .delete_12_regular,
                                                    color: Colors.redAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          collapsed: Container(),
                                          expanded: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 5),
                                              state
                                                          .datalist
                                                          .listdata![index]
                                                          .checkOut ==
                                                      null
                                                  ? Row(
                                                    children: [
                                                      Text(
                                                        timeFormat.format(
                                                          DateTime.parse(
                                                            state
                                                                .datalist
                                                                .listdata![index]
                                                                .checkIn
                                                                .toString(),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(" - "),
                                                      Text(
                                                        "Belum Pulang",
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                  : Row(
                                                    children: [
                                                      Text(
                                                        timeFormat.format(
                                                          DateTime.parse(
                                                            state
                                                                .datalist
                                                                .listdata![index]
                                                                .checkIn
                                                                .toString(),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(" - "),
                                                      Text(
                                                        timeFormat.format(
                                                          DateTime.parse(
                                                            state
                                                                .datalist
                                                                .listdata![index]
                                                                .checkOut
                                                                .toString(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Tempat: ${state.datalist.listdata![index].checkInAddress.toString()}",
                                              ),
                                            ],
                                          ),
                                          builder: (_, collapsed, expanded) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10,
                                              ),
                                              child: Expandable(
                                                collapsed: collapsed,
                                                expanded: expanded,
                                                theme:
                                                    const ExpandableThemeData(
                                                      crossFadePoint: 0,
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                  return Center(
                    child: Text("Failed To Load Data", style: kanit20BoldMain),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
