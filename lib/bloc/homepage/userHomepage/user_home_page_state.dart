part of 'user_home_page_bloc.dart';

@immutable
sealed class UserHomePageState {}

final class UserHomePageInitial extends UserHomePageState {}

final class UserHomePageSuccses extends UserHomePageState {
  final ProfileModel data;
  UserHomePageSuccses({required this.data});
}

final class UserHomePageLoading extends UserHomePageState {}

final class UserHomePageFailed extends UserHomePageState {}
