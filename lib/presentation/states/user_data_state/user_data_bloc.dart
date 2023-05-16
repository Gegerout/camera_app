import 'package:bloc/bloc.dart';
import 'package:camera_app/data/repositories/data_repository.dart';
import 'package:camera_app/domain/usecases/user_data_usecase.dart';
import 'package:meta/meta.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(UserDataInitial()) {
    on<SaveUserData>((event, emit) async {
      await DataRepository().saveUserDataImpl(event.name, event.surname, event.image);
    });
    on<GetUserData>((event, emit) async {
      final user = await DataRepository().getUserData();
      //print(user != null ? user.image : "");
      emit(UserDataState(user: user));
    });
    on<GetAllUserData>((event, emit) async {
      final user = await DataRepository().getAllUserData();
      //print(user != null ? user.image : "");
      emit(AllDataLoadedState(user));
    });
  }
}
