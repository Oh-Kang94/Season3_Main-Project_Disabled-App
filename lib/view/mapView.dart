// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // class mapView extends StatelessWidget {
// //   const mapView({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Map'),
// //       ),
// //       body: const Center(
// //         child:
// //         // Obx(() => mapController.mapModel.isNotEmpty
// //             // ?
// //             SizedBox(
// //               height: 600,
// //               width: 200,
// //               child: GoogleMap(
// //                   mapType: MapType.normal,
// //                   initialCameraPosition: CameraPosition(
// //                     target: LatLng(
// //                       // mapController.mapModel.first.latitude,
// //                         // mapController.mapModel.first.longitude
// //                         37.494552,127.029932 //지도 처음 뜰 때 보여줄 좌표 값
// //                         ),
// //                     zoom: 18,
// //                   ),
// //                 ),
// //             ),

// //             // : Center(
// //                 // child: CircularProgressIndicator(),
// //               // ),
// //               // ),

// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // import '../vm/map_controller.dart';

// // class mapView extends StatefulWidget {
// //   mapView({super.key});

// //   MapController _mapController = MapController();

// //   @override
// //   State<mapView> createState() => _mapViewState();
// // }

// // class _mapViewState extends State<mapView> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Map'),

// //       ),
// //       body: const Center(
// //         child: SizedBox(
// //           height: 600,
// //           width: 400,
// //           child: GoogleMap(
// //             mapType: MapType.normal,
// //             initialCameraPosition: CameraPosition(
// //               target: LatLng(37.494552, 127.029932),
// //               zoom: 18,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// //stateful로 다시 코드 짜기
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../vm/map_controller.dart';

// class MapViewPage extends StatefulWidget {
//   @override
//   _MapViewPageState createState() => _MapViewPageState();
// }

// class _MapViewPageState extends State<MapViewPage> {
//   final MapController _mapController = MapController();

//   @override
//   void initState() {
//     super.initState();
//     _loadLocationData();
//   }

//   Future<void> _loadLocationData() async {
//     await _mapController.fetchLocations();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map View'),
//       ),
//       body: Center(
//         child: _mapController.markers.isNotEmpty
//             ? GoogleMap(
//                 mapType: MapType.normal,
//                 initialCameraPosition: CameraPosition(
//                   target: LatLng(37.494552, 127.029932),
//                   zoom: 18,
//                 ),
//                 markers: _mapController.markers.toSet(),
//               )
//             : CircularProgressIndicator(), // 데이터 로딩 중에는 로딩 인디케이터 표시
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../vm/map_controller.dart';

class MapViewPage extends StatefulWidget {
  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _loadLocationData();
  }

  Future<void> _loadLocationData() async {
    await _mapController.fetchLocations();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
      ),
      body: FutureBuilder(
        future: _loadLocationData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.494552, 127.029932),
                  zoom: 13,
                ),
                markers: _mapController.markers.toSet(),
              ),
            );
          }
        },
      ),
    );
  }
}
