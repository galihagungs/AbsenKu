import 'package:absenku/service/absenService.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_izin_event.dart';
part 'delete_izin_state.dart';

class DeleteIzinBloc extends Bloc<DeleteIzinEvent, DeleteIzinState> {
  DeleteIzinBloc() : super(DeleteIzinInitial()) {
    on<DeleteIzinEvent>((event, emit) async {
      if (event is DeleteIzin) {
        emit(DeleteIzinLoading());
        await Absenservice().delete(idAbsen: event.idAbsen);
        emit(DeleteIzinSuccess());
      }
    });
  }
}
