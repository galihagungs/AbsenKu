import 'package:absenku/model/ProfileModel.dart';
import 'package:absenku/service/UserService.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_home_page_event.dart';
part 'user_home_page_state.dart';

class UserHomePageBloc extends Bloc<UserHomePageEvent, UserHomePageState> {
  UserHomePageBloc() : super(UserHomePageInitial()) {
    on<UserHomePageEvent>((event, emit) async {
      if (event is SetupData) {
        emit(UserHomePageLoading());

        ProfileModel data = await UserService().getProfile();
        // print(data.message);
        emit(UserHomePageSuccses(data: data));
      }
    });
  }
}
