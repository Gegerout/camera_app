import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_app/presentation/pages/home_page.dart';
import 'package:camera_app/presentation/states/user_data_state/user_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import 'camera_page.dart';

class UserCardPage extends StatefulWidget {
  const UserCardPage({Key? key}) : super(key: key);

  @override
  State<UserCardPage> createState() => _UserCardPageState();
}

class _UserCardPageState extends State<UserCardPage> {
  late XFile? file;
  late String? name;
  late String? surname;
  late VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    file = null;
    name = null;
    surname = null;
    controller = null;
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameCont = TextEditingController(text: name);
    TextEditingController surnameCont = TextEditingController(text: surname);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  if(file != null) {
                    if(file!.path.endsWith("mp4")) {
                      return SizedBox(
                        height: 100,
                        width: 100,
                        child: IconButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CameraPage(name: nameCont.text, surname: surnameCont.text)
                                  )
                              );
                              setState(() {
                                file = result[0];
                                name = result[1];
                                surname = result[2];
                                if(file!.path.endsWith("mp4")) {
                                  controller = VideoPlayerController.file(File(file != null ? file!.path : ""));
                                  controller!.setLooping(true);
                                  controller!.initialize().then((_) {
                                    setState(() {});
                                  });
                                  controller!.play();
                                }
                              });
                            },
                            icon: SizedBox(
                                width: 100,
                                height: 100,
                                child: VideoPlayer(controller!)
                            )
                        ),
                      );
                    }
                    return SizedBox(
                      height: 100,
                      width: 100,
                      child: IconButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CameraPage(name: nameCont.text, surname: surnameCont.text,)
                                )
                            );
                            setState(() {
                              file = result[0];
                              name = result[1];
                              surname = result[2];
                              if(file!.path.endsWith("mp4")) {
                                controller = VideoPlayerController.file(File(file != null ? file!.path : ""));
                                controller!.setLooping(true);
                                controller!.initialize().then((_) {
                                  setState(() {});
                                });
                                controller!.play();
                              }
                            });
                          },
                          icon: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.file(
                                File(file!.path),
                                fit: BoxFit.fill,
                              ))),
                    );
                  }
                  return IconButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                CameraPage(name: nameCont.text, surname: surnameCont.text)
                            )
                        );
                        setState(() {
                          file = result[0];
                          name = result[1];
                          surname = result[2];
                          controller = VideoPlayerController.file(File(file != null ? file!.path : ""));
                          controller!.setLooping(true);
                          controller!.initialize().then((_) {
                            setState(() {});
                          });
                          controller!.play();
                        });
                      },
                      icon: const SizedBox(
                        height: 100,
                        width: 100,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                        ),
                      )
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: nameCont,
                  decoration: const InputDecoration(
                    hintText: "Имя",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: surnameCont,
                  decoration: const InputDecoration(
                    hintText: "Фамилия",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<UserDataBloc>().add(SaveUserData(nameCont.text, surnameCont.text, file?.path));
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                      },
                      child: const Text("Сохранить")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
