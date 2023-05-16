part of 'user_data_bloc.dart';

class UserDataState {
  UserDataUseCase? user;

  UserDataState({this.user});
}

class UserDataInitial extends UserDataState {}

class AllDataLoadedState extends UserDataState {
  final UserDataUseCase user;

  AllDataLoadedState(this.user);
}
