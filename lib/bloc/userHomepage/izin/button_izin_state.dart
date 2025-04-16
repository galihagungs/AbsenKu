part of 'button_izin_bloc.dart';

@immutable
sealed class ButtonIzinState {}

final class ButtonIzinInitial extends ButtonIzinState {}

final class ButtonIzinSuccses extends ButtonIzinState {
  final absenModel absenData;

  ButtonIzinSuccses({required this.absenData});
}

final class ButtonIzinFailed extends ButtonIzinState {}

final class ButtonIzinLoading extends ButtonIzinState {}
