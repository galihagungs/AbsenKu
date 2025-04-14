import 'package:absenku/model/ProfileModel.dart';
import 'package:absenku/service/UserService.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_home_page_event.dart';
part 'user_home_page_state.dart';

class UserHomePageBloc extends Bloc<UserHomePageEvent, UserHomePageState> {
  UserHomePageBloc() : super(UserHomePageInitial()) {
    on<UserHomePageEvent>((event, emit) async {
      if (event is GetUser) {
        emit(UserHomePageLoading());
        ProfileModel data = await UserService().getProfile(token: event.token);
        emit(UserHomePageSuccses(data: data));
      }
    });
  }
}
