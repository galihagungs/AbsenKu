part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetData extends ProfileEvent {}

class EditMode extends ProfileEvent {
  final ProfileModel data;

  EditMode({required this.data});
}

class UpdateData extends ProfileEvent {
  final String email;
  final String name;

  UpdateData({required this.email, required this.name});
}
