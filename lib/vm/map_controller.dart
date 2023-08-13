import 'dart:convert';
import 'dart:html';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../model/mapModel.dart';

class MapController extends GetxController {
  List<MapModel> mapModel = <MapModel>[].obs;
  var markers = RxSet<Marker>();
  RxBool isLoading = false.obs;
  var Url = Uri.tryParse('http://www.oh-kang.kro.kr:7288/maps/');

  fetchLocations() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Url!);//강현이url에서 데이터 parsing
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);//가져온 jsondata디코딩
        List<dynamic> resultMapList = result as List<dynamic>;
        mapModel.addAll(resultMapList
            .map((e) => MapModel.fromJson(e as Map<String, dynamic>))
            .toList());//가져온 데이터를 mapModel리스트에 추가.
      }
    } catch (e) {
      print('데이터를 가져오는 도중 오류 발생: $e');
    } finally {
      isLoading(false);
      print('최종적으로 데이터 가져옴: $mapModel');
      createMarkersWithData(mapModel);
    }
  }

  // 데이터를 불러와서 마커를 생성하는 함수
  createMarkersWithData(List<MapModel> data) async {
    markers.clear(); // 기존 마커를 지웁니다.
    for (var map in data) {
      // 주소를 좌표로 변환하는 과정
      try {
        List<Location> locations = await locationFromAddress(map.address);
        if (locations.isNotEmpty) {
          LatLng latLng = LatLng(locations.first.latitude, locations.first.longitude);
          markers.add(Marker(
            markerId: MarkerId(map.seq),
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

  // 데이터를 불러오고 지오코딩을 적용하여 마커 생성
  fetchAndCreateMarkers() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Url!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        List<dynamic> resultMapList = result as List<dynamic>;
        List<MapModel> parsedData = resultMapList
            .map((e) => MapModel.fromJson(e as Map<String, dynamic>))
            .toList();

        mapModel.addAll(parsedData); // 파싱된 데이터를 mapModel 리스트에 추가.
        await createMarkersWithData(parsedData); // 지오코딩을 적용하여 마커를 생성.
      }
    } catch (e) {
      print('데이터를 가져오는 도중 오류 발생: $e');
    } finally {
      isLoading(false);
      print('최종적으로 데이터 가져옴: $mapModel');
    }
  }

  @override
  void onInit() {
    fetchAndCreateMarkers(); // 데이터를 가져와서 마커를 생성하는 함수를 호출합니다.
    super.onInit();
  }
}