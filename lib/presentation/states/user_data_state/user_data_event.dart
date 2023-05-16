part of 'user_data_bloc.dart';

@immutable
abstract class UserDataEvent {}

class SaveUserData extends UserDataEvent {
  final String? name;
  final String? surname;
  final String? image;

  SaveUserData(this.name, this.surname, this.image);
}

class GetUserData extends UserDataEvent {}

class GetAllUserData extends UserDataEvent {}
