import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import 'address_access.dart';
// import 'address_dept_server.dart';
import '../model/ai_address_access_model.dart';
import '../model/ai_address_server_model.dart';
import '../model/user_model.dart';
import '../util/api_endpoint.dart';

class AddressController extends GetxController {
  String? userId;
  UserData? userData;

  final isLoading = true.obs;
  final hasError = false.obs;
  final error = "".obs;
  final hasData = false.obs;
  final addresses = <AddressDepthServerModel>[].obs;
  final subAddresses = <AddressDepthServerModel>[].obs;
  final subAddresses1 = <AddressDepthServerModel>[].obs;
  final selectedAddress = AddressDepthServerModel(code: '', name: '').obs;
  String address_result = "";
  String subAddress_result = "";
  String subAddresses1_result = "";
  String address_result111 = "";
  String subAddress_result111 = "";
  // String subAddresses1_result111 = "";
  bool addressStatus = false;

  // get userData => null;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses(); // 시 데이터 처음에 보여주기위해 init에 넣기
    loadUser();
  }

  /// 시 데이터 넘겨주기
  void address(String address) {
    address_result = address;
    address_result111 = "$address >";
    update();
  }

  // 구 데이터 넘겨주기
  void subAddressesR(String subAddresses) {
    subAddress_result = subAddresses;
    subAddress_result111 = "$subAddresses >";
    update();
  }

  // 동 데이터 넘겨주기
  void subAddresses1R(String subAddresses1) {
    subAddresses1_result = subAddresses1;
    update();
  }

  //

  // 처음 accessToken받기위함
  Future<String?> getSgisApiAccessToken() async {
    try {
      const String _key = "ed5c614064114780be63";
      const String _secret = "efd16460b63947808bcd";
      final response = await http.get(
        Uri.parse(
            "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json?consumer_key=$_key&consumer_secret=$_secret"),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body)['result'];
        final AccessTokenModel accessTokenModel =
            AccessTokenModel.fromJson(data);
        String accessToken = accessTokenModel.accessToken;

        return accessToken; // AccessToken 반환
      } else {
        throw Exception('Failed to load addresses');
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // 받은 accessToken을 이용해서 시 데이터 불러오기
  Future<void> fetchAddresses() async {
    try {
      String? accessToken = await getSgisApiAccessToken(); // AccessToken 받아오기
      final response = await http.get(
        Uri.parse(
            "https://sgisapi.kostat.go.kr/OpenAPI3/addr/stage.json?accessToken=$accessToken"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['result'];
        addresses.assignAll(data
            .map((dynamic item) => AddressDepthServerModel.fromJson(item))
            .toList());
        isLoading.value = false;
        hasData.value = true;
      } else {
        throw Exception('Failed to load addresses');
      }
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      error.value = e.toString();
    }
  }

  // 선택된 시 데이터code로 구 데이터 불러오기
  void loadSubAddresses(String selectedCode) async {
    try {
      String? accessToken = await getSgisApiAccessToken(); // AccessToken 받아오기
      final response = await http.get(
        Uri.parse(
            "https://sgisapi.kostat.go.kr/OpenAPI3/addr/stage.json?accessToken=$accessToken&cd=$selectedCode"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['result'];
        subAddresses.assignAll(data
            .map((dynamic item) => AddressDepthServerModel.fromJson(item))
            .toList());
      } else {
        throw Exception('Failed to load sub addresses');
      }
    } catch (e) {
      // Handle error
    }
  }

  // 선택된 구 데이터code로 동 데이터 불러오기
  Future<void> loadSubAddressDetails(String subAddressCode) async {
    try {
      String? accessToken = await getSgisApiAccessToken(); // AccessToken 받아오기
      final response = await http.get(
        Uri.parse(
            "https://sgisapi.kostat.go.kr/OpenAPI3/addr/stage.json?accessToken=$accessToken&cd=$subAddressCode"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['result'];
        subAddresses1.assignAll(data
            .map((dynamic item) => AddressDepthServerModel.fromJson(item))
            .toList());
      } else {
        throw Exception('Failed to load sub addresses');
      }
    } catch (e) {
      // Handle error
    }
  }

    loadUser() async {
    await getSharedPreferences();
    if (userId != null) {
      String baseUrl = ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.getUser;
      String requestUri = "$baseUrl/?id=$userId";
      try {
        var response = await GetConnect().get(requestUri);
        if (response.isOk) {
          userData = UserData.fromJson(response.body);
          print("이름은 이래: username: ${userData!.name}");
          update();
          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    }
  }

  getSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('userId');
    } catch (e) {
      print(e);
    }
    print("LOAD SHAREDPREFERENCE: userid: $userId");
  }

}
