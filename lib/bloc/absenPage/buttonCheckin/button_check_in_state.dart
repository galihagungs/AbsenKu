part of 'button_check_in_bloc.dart';

@immutable
sealed class ButtonCheckInState {}

final class ButtonCheckInInitial extends ButtonCheckInState {}

final class ButtonCheckLoading extends ButtonCheckInState {}

final class ButtonCheckFailed extends ButtonCheckInState {
  final absenModel data;

  ButtonCheckFailed({required this.data});
  List<Object?> get props => [data];
}

final class ButtonCheckSucsess extends ButtonCheckInState {
  final absenModel data;

  ButtonCheckSucsess({required this.data});
  List<Object?> get props => [data];
}
