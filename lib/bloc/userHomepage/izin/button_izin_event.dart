part of 'button_izin_bloc.dart';

@immutable
sealed class ButtonIzinEvent {}

class CommitData extends ButtonIzinEvent {
  final String alasanIzin;

  CommitData({required this.alasanIzin});
}
