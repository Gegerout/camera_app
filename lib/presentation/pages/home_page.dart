import 'package:camera_app/presentation/pages/draggable_list_page.dart';
import 'package:camera_app/presentation/pages/map_page.dart';
import 'package:camera_app/presentation/pages/profile_page.dart';
import 'package:camera_app/presentation/pages/sensors_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const MapPage(),
      const SensorsPage(),
      const DraggableListPage(),
      const ProfilePage()
    ];
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIndex: selectedIndex,
        destinations: const [
        NavigationDestination(
          icon: Icon(Icons.location_on),
          label: 'Map',
        ),
        NavigationDestination(
          icon: Icon(Icons.sensors),
          label: 'Sensors',
        ),
        NavigationDestination(
          icon: Icon(Icons.list),
          label: 'List',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      ),
    );
  }
}
