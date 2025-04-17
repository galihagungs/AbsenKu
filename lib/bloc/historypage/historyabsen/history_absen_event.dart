// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_absen_bloc.dart';

@immutable
sealed class HistoryAbsenEvent {}

class GetData extends HistoryAbsenEvent {}

class FilterHistory extends HistoryAbsenEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  FilterHistory({required this.startDate, required this.endDate});
}
