import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({Key? key}) : super(key: key);

  @override
  State<SensorsPage> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {

  @override
  Widget build(BuildContext context) {
    double dx = MediaQuery.of(context).size.width / 2 - 25, dy = MediaQuery.of(context).size.height / 2 - 25;

    return Scaffold(
      body: StreamBuilder<GyroscopeEvent>(
        stream: SensorsPlatform.instance.gyroscopeEvents,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            dx = dx + (snapshot.data!.y * 10);
            dy = dy + (snapshot.data!.x * 10);
          }
          return Transform.translate(
            offset: Offset(dx, dy),
            child: const CircleAvatar(
              radius: 25,
            ),
          );
        },
      ),
    );
  }
}
