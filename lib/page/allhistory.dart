import 'package:absenku/bloc/historypage/historyabsen/history_absen_bloc.dart';
import 'package:absenku/utils/toast.dart';
import 'package:absenku/utils/utils.dart';
import 'package:absenku/utils/wiget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Allhistory extends StatefulWidget {
  const Allhistory({super.key});

  @override
  State<Allhistory> createState() => _AllhistoryState();
}

class _AllhistoryState extends State<Allhistory> {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateTime? startDate;
  DateTime? endDate;
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
    showToast("$startDate - $endDate", success: true);
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
                    return ListView.builder(
                      itemCount: state.datalist.listdata!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(color: mainColor),
                            child: Text(
                              state.datalist.listdata![index].id.toString(),
                            ),
                          ),
                        );
                      },
                    );
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
}
