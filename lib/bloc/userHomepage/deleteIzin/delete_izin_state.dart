part of 'delete_izin_bloc.dart';

@immutable
sealed class DeleteIzinState {}

final class DeleteIzinInitial extends DeleteIzinState {}

final class DeleteIzinLoading extends DeleteIzinState {}

final class DeleteIzinSuccess extends DeleteIzinState {}

final class DeleteIzinFailed extends DeleteIzinState {}
