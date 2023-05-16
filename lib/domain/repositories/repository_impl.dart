import '../usecases/user_data_usecase.dart';

abstract class RepositoryImpl {
  Future<void> saveUserDataImpl(String? name, String? surname, String? image);
  Future<UserDataUseCase?> getUserData();
  Future<UserDataUseCase> getAllUserData();
}