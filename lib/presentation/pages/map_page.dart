import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController mapController = MapController(
    initMapWithUserPosition: true
  );

  var markerMap = <String, String>{};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapController.listenerMapSingleTapping.addListener(() async {
        var position = mapController.listenerMapSingleTapping.value;
        if(position != null) {
          await mapController.addMarker(position, markerIcon: const MarkerIcon(
            icon: Icon(Icons.pin_drop, color: Colors.blue, size: 48,),
          ));

          var key = "${position.latitude}_${position.longitude}";
          markerMap[key] = markerMap.length.toString();
        }
      });
    });
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OSMFlutter(
          controller: mapController,
        mapIsLoading: const Center(child: CircularProgressIndicator(),),
        trackMyPosition: true,
        initZoom: 17,
        minZoomLevel: 4,
        maxZoomLevel: 19,
        stepZoom: 1,
        userLocationMarker: UserLocationMaker(personMarker: const MarkerIcon(
          icon: Icon(Icons.person, color: Colors.black, size: 48,),
        ), directionArrowMarker: const MarkerIcon(
          icon: Icon(Icons.location_on, color: Colors.black, size: 48,),
        )),
        roadConfiguration: const RoadOption(roadColor: Colors.blueGrey),
        markerOption: MarkerOption(
          defaultMarker: const MarkerIcon(
            icon: Icon(Icons.person_pin_circle, color: Colors.black, size: 48,),
          )
        ),
        onMapIsReady: (isReady) async {
            await Future.delayed(const Duration(seconds: 1), () async {
              await mapController.currentLocation();
            });
        },
        onGeoPointClicked: (geoPoint) {
            var key = "${geoPoint.latitude}_${geoPoint.longitude}";
            showModalBottomSheet(context: context, builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("Position ${markerMap[key]}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
                    Text(key, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                  ],
                ),
              );
            });
        },
      ),
    );
  }
}
