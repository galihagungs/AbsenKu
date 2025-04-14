part of 'user_home_page_bloc.dart';

@immutable
sealed class UserHomePageEvent {}

class GetUser extends UserHomePageEvent {
  final String token;

  GetUser({required this.token});
}
