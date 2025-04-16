part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final ProfileModel profileData;

  ProfileSuccess({required this.profileData});
  List<Object?> get props => [profileData];
}

final class ProfileFailed extends ProfileState {}

final class ProfileEditMode extends ProfileState {
  final ProfileModel profileData;

  ProfileEditMode({required this.profileData});
  List<Object?> get props => [profileData];
}
