part of 'button_check_out_bloc.dart';

@immutable
sealed class ButtonCheckOutEvent {}

class CheckOut extends ButtonCheckOutEvent {
  final double lat;
  final double long;
  final String addres;
  final String currentLatLong;

  CheckOut({
    required this.lat,
    required this.long,
    required this.addres,
    required this.currentLatLong,
  });
}
