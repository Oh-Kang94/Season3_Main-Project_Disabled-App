import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../vm/map_controller.dart';

class MapViewPage extends StatelessWidget {
  const MapViewPage({super.key});

  @override
  Widget build(BuildContext context) {
  final MapController mapController = MapController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
      ),
      body: FutureBuilder(
        future: mapController.fetchAndCreateMarkers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.494552, 127.029932),
                  zoom: 13,
                ),
                markers: mapController.markers.toSet(),
              ),
            );
          }
        },
      ),
    );
  }
}
