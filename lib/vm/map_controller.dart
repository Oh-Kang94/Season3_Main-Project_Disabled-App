import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../model/mapModel.dart';

class MapController extends GetxController{
  
  //변수선언부
  List<MapModel> mapModel = <MapModel>[].obs;//mapmodel을 가져올 것
  var markers = RxSet<Marker>(); //map에 marker찍어줄 변수
  RxBool isLoading = false.obs;//완료되었는지 여부 bool함수
  var Url =  Uri.tryParse('');

  //api url제공하는 함수
    //결과를 얻은 뒤에 문자열 맵목록으로 변환 시킨다.
    //그 후 다시 모델에 추가하는 과정을 거치는 함수
  fetchLocations() async{
    try{
      isLoading(true);
      http.Response response = await http.get(Url!);
      if(response.statusCode ==200){
        var result = jsonDecode(response.body);
        log(result.toString());
        mapModel.addAll(RxList<Map<String,dynamic>>.from(result)
          .map((e) => MapModel.fromJson(e))
          .toList());
      }
    } catch(e){
      print('Error while getting data is $e');
    } finally{
      isLoading(false);
      print('finally: $mapModel');
      createMarkers();//마커를 생성하는 함수
    }
  }
  //완료되면 로딩을 거짓으로 만든 뒤 api에서 가져온 위치에 마커를 생성해야 한다.


  //마커 생성함수
  createMarkers(){
    mapModel.forEach((list) {
      markers.add(Marker(
        markerId: MarkerId(list.id.toString()),  
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(list.latitude, list.longitude),
        infoWindow: InfoWindow(title: list.name, snippet: list.city),
        onTap: () {
          print('market tapped');
        },

      ),);
    });
  }
}