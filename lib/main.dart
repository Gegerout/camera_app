import 'package:camera/camera.dart';
import 'package:camera_app/presentation/pages/home_page.dart';
import 'package:camera_app/presentation/pages/user_card_page.dart';
import 'package:camera_app/presentation/states/user_data_state/user_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MultiBlocProvider(
      providers: [BlocProvider(create: (context) => UserDataBloc())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserDataBloc>(context).add(GetUserData());
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          if (state.user != null) {
            return HomePage();
          }
          return UserCardPage();
        },
      ),
    );
  }
}
