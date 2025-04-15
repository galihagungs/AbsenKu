// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'button_check_in_bloc.dart';

@immutable
sealed class ButtonCheckInEvent {}

class CheckIn extends ButtonCheckInEvent {
  final double lat;
  final double long;
  final String addres;

  CheckIn({required this.lat, required this.long, required this.addres});
}
