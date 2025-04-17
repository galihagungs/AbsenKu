part of 'history_absen_bloc.dart';

@immutable
sealed class HistoryAbsenState {}

final class HistoryAbsenInitial extends HistoryAbsenState {}

final class HistoryAbsenSuccees extends HistoryAbsenState {
  final absenModel datalist;
  HistoryAbsenSuccees({required this.datalist});
  List<Object?> get props => [datalist];
}

final class HistoryAbsenLoading extends HistoryAbsenState {}

final class HistoryAbsenFailed extends HistoryAbsenState {}
