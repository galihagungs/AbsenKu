part of 'button_check_out_bloc.dart';

@immutable
sealed class ButtonCheckOutState {}

final class ButtonCheckOutInitial extends ButtonCheckOutState {}

final class ButtonCheckOutSucsess extends ButtonCheckOutState {
  final absenModel model;

  ButtonCheckOutSucsess({required this.model});
  List<Object?> get props => [model];
}

final class ButtonCheckOutLoading extends ButtonCheckOutState {}

final class ButtonCheckOutFailed extends ButtonCheckOutState {}
