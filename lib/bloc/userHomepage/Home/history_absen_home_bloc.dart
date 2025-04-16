import 'package:absenku/model/AbsenModel.dart';
import 'package:absenku/service/absenService.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'history_absen_home_event.dart';
part 'history_absen_home_state.dart';

class HistoryAbsenHomeBloc
    extends Bloc<HistoryAbsenHomeEvent, HistoryAbsenHomeState> {
  HistoryAbsenHomeBloc() : super(HistoryAbsenHomeInitial()) {
    on<HistoryAbsenHomeEvent>((event, emit) async {
      emit(HistoryAbsenHomeLoading());
      absenModel data = await Absenservice().getHistoryHome();
      emit(HistoryAbsenHomeSuccess(data: data));
    });
  }
}
