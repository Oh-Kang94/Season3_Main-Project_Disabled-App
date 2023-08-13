import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../model/mapModel.dart';

class MapController extends GetxController {
  List<MapModel> mapModel = <MapModel>[].obs;
  var markers = RxSet<Marker>();
  RxBool isLoading = false.obs;
  var Url = Uri.parse('http://www.oh-kang.kro.kr:7288/maps/');

  @override
  void onInit() {
    fetchAndCreateMarkers();
    super.onInit();
  }

  // 데이터를 불러오고 지오코딩을 적용하여 마커 생성
  fetchAndCreateMarkers() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Url);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<dynamic> result = jsonData['result'];
        List<MapModel> parsedData = result
            .map((e) => MapModel.fromJson(e as Map<String, dynamic>))
            .toList();

        mapModel.addAll(parsedData);
        // await createMarkersWithData(parsedData); // 지오코딩을 적용하여 마커를 생성.
      }
    } catch (e) {
      print('데이터를 가져오는 도중 오류 발생: $e');
    } finally {
      isLoading(false);
      print('최종적으로 데이터 가져옴: ${mapModel[0].name}');
    }
  }

  // 데이터를 불러와서 마커를 생성하는 함수
  createMarkersWithData(List<MapModel> data) async {
    markers.clear(); // 기존 마커를 지웁니다.
    for (var map in data) {
      try {
        final List<Location> locations =
            await locationFromAddress(map.address, localeIdentifier: "kor_KO");

        if (locations.isNotEmpty) {
          final LatLng latLng =
              LatLng(locations.first.latitude, locations.first.longitude);
          markers.add(Marker(
            markerId: MarkerId(map.seq.toString()),
            position: latLng,
            infoWindow: InfoWindow(
              title: map.name,
              snippet: map.address,
            ),
          ));
        }
      } catch (e) {
        print('주소를 좌표로 변환하는 도중 오류 발생: $e');
      }
    }
  }
}
