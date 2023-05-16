import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, this.name, this.surname}) : super(key: key);

  final String? name;
  final String? surname;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  late bool isRecording;

  @override
  void initState() {
    super.initState();
    isRecording = false;
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      print(e);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  recordVideo() async {
    await controller.setFlashMode(FlashMode.auto);
    if(isRecording) {
      final file = await controller.stopVideoRecording();
      setState(() {
        isRecording = false;
      });
      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => VideoPage(file: file)), (route) => false);
      Navigator.pop(context, [file, widget.name, widget.surname]);
    }
    else {
      await controller.prepareForVideoRecording();
      await controller.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    }
  }

  takePhoto() async {
    await controller.setFlashMode(FlashMode.auto);
    final file = await controller.takePicture();
    Navigator.pop(context, [file, widget.name, widget.surname]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: CameraPreview(controller),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: FloatingActionButton(
                          heroTag: "btn1",
                          backgroundColor: Colors.red,
                          onPressed: isRecording ? null : () async {
                            if(!controller.value.isInitialized) {
                              return null;
                            }
                            if(controller.value.isTakingPicture) {
                              return null;
                            }
                            try {
                              takePhoto();
                            } on CameraException catch (e) {
                              return null;
                            }
                          }, child: const Icon(Icons.camera),)
                    ),
                    const SizedBox(width: 20,),
                    Center(
                        child: FloatingActionButton(
                          heroTag: "btn2",
                          backgroundColor: Colors.red,
                          onPressed: () async {
                            if(!controller.value.isInitialized) {
                              return null;
                            }
                            if(controller.value.isTakingPicture) {
                              return null;
                            }
                            try {
                              recordVideo();
                            } on CameraException catch (e) {
                              return null;
                            }
                          }, child: Icon(isRecording ? Icons.stop : Icons.circle),)
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}