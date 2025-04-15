import 'package:absenku/model/AbsenModel.dart';
import 'package:absenku/service/absenService.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'button_check_in_event.dart';
part 'button_check_in_state.dart';

class ButtonCheckInBloc extends Bloc<ButtonCheckInEvent, ButtonCheckInState> {
  ButtonCheckInBloc() : super(ButtonCheckInInitial()) {
    on<ButtonCheckInEvent>((event, emit) async {
      if (event is CheckIn) {
        emit(ButtonCheckLoading());
        absenModel data = await Absenservice().absenMasuk(
          lat: event.lat,
          long: event.long,
          addres: event.addres,
        );
        emit(ButtonCheckSucsess(data: data));
      }
    });
  }
}
