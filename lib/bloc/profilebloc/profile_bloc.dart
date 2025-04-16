import 'package:absenku/model/ProfileModel.dart';
import 'package:absenku/service/UserService.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetData) {
        emit(ProfileLoading());
        ProfileModel profileData = await UserService().getProfile();
        emit(ProfileSuccess(profileData: profileData));
      } else if (event is EditMode) {
        emit(ProfileEditMode(profileData: event.data));
      } else if (event is UpdateData) {
        emit(ProfileLoading());
        ProfileModel profileData = await UserService().updateProfile(
          email: event.email,
          nama: event.name,
        );
        emit(ProfileSuccess(profileData: profileData));
      }
    });
  }
}
