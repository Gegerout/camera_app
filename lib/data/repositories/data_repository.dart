import 'package:camera_app/data/datasources/get_user_data.dart';
import 'package:camera_app/domain/usecases/user_data_usecase.dart';

import '../../domain/repositories/repository_impl.dart';
import '../datasources/save_user_data.dart';

class DataRepository extends RepositoryImpl {
  @override
  Future<void> saveUserDataImpl(String? name, String? surname, String? image) async {
    await SaveUserData().savePersonalData(name, surname, image);
  }

  @override
  Future<UserDataUseCase?> getUserData() async {
    final user = await GetUserData().getUserData();
    if(user != null) {
      final usecase = UserDataUseCase(user.name, user.surname, user.image);
      return usecase;
    }
    return null;
  }

  @override
  Future<UserDataUseCase> getAllUserData() async {
    final user = await GetUserData().getAllUserData();
    final usecase = UserDataUseCase(user.name, user.surname, user.image);
    return usecase;
  }
}