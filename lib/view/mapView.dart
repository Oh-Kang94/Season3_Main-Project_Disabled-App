import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapView extends StatelessWidget {
  const mapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Center(
        child: 
        // Obx(() => mapController.mapModel.isNotEmpty
            // ? 
            SizedBox(
              height: 600,
              width: 400,
              child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      // mapController.mapModel.first.latitude,
                        // mapController.mapModel.first.longitude
                        37.494552,127.029932 //지도 처음 뜰 때 보여줄 좌표 값
                        ),
                    zoom: 18,
                  ),
                ),
            ),
              
            // : Center(
                // child: CircularProgressIndicator(),
              // ),
              // ),
              
      ),
    );
  }
}