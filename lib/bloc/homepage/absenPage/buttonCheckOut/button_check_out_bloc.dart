import 'package:absenku/model/AbsenModel.dart';
import 'package:absenku/service/absenService.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'button_check_out_event.dart';
part 'button_check_out_state.dart';

class ButtonCheckOutBloc
    extends Bloc<ButtonCheckOutEvent, ButtonCheckOutState> {
  ButtonCheckOutBloc() : super(ButtonCheckOutInitial()) {
    on<ButtonCheckOutEvent>((event, emit) async {
      if (event is CheckOut) {
        emit(ButtonCheckOutLoading());
        absenModel data = await Absenservice().absenMasuk(
          lat: event.lat,
          long: event.long,
          addres: event.addres,
        );

        emit(ButtonCheckOutSucsess(model: data));
      }
    });
  }
}
