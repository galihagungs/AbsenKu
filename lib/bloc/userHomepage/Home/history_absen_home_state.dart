part of 'history_absen_home_bloc.dart';

@immutable
sealed class HistoryAbsenHomeState {}

final class HistoryAbsenHomeInitial extends HistoryAbsenHomeState {}

final class HistoryAbsenHomeSuccess extends HistoryAbsenHomeState {
  final absenModel data;
  HistoryAbsenHomeSuccess({required this.data});
}

final class HistoryAbsenHomeFailed extends HistoryAbsenHomeState {}

final class HistoryAbsenHomeLoading extends HistoryAbsenHomeState {}
