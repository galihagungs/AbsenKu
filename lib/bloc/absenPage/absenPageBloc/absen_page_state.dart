part of 'absen_page_bloc.dart';

@immutable
sealed class AbsenPageState {}

final class AbsenPageInitial extends AbsenPageState {}

final class AbsenPageSucsess extends AbsenPageState {
  final String currentAddress;
  final String currentLatLong;
  final double currentLat;
  final double currentLong;

  AbsenPageSucsess({
    required this.currentAddress,
    required this.currentLatLong,
    required this.currentLat,
    required this.currentLong,
  });

  List<Object?> get props => [
    currentAddress,
    currentLatLong,
    currentLat,
    currentLong,
  ];
}

final class AbsenPageLoading extends AbsenPageState {}

final class AbsenPageFailed extends AbsenPageState {}
