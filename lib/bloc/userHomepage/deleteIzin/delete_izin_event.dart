part of 'delete_izin_bloc.dart';

@immutable
sealed class DeleteIzinEvent {}

class DeleteIzin extends DeleteIzinEvent {
  final int idAbsen;

  DeleteIzin({required this.idAbsen});
}
