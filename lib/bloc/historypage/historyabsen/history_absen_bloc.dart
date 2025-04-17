import 'package:absenku/model/AbsenModel.dart';
import 'package:absenku/service/absenService.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'history_absen_event.dart';
part 'history_absen_state.dart';

class HistoryAbsenBloc extends Bloc<HistoryAbsenEvent, HistoryAbsenState> {
  HistoryAbsenBloc() : super(HistoryAbsenInitial()) {
    on<HistoryAbsenEvent>((event, emit) async {
      if (event is GetData) {
        emit(HistoryAbsenLoading());
        absenModel data = await Absenservice().getHistoryPage();
        emit(HistoryAbsenSuccees(datalist: data));
      } else if (event is FilterHistory) {
        emit(HistoryAbsenLoading());
        absenModel data = await Absenservice().getHistoryFilterPage(
          startDate: event.startDate,
          endDate: event.endDate,
        );
        emit(HistoryAbsenSuccees(datalist: data));
      }
    });
  }
}
