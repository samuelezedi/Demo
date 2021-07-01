import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeFeedsRepo {
  static final String _weatherBaseUrl = "https://api.ambeedata.com";
  static final String _userBaseUrl =
      "https://jsonplaceholder.typicode.com/users";

  static Future getUsers() async {
    int number = new Random().nextInt(10);
    Dio dio = Dio();
    String url = _userBaseUrl + "/$number";
    try {
      Response response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      return;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  static Future getWeatherFeeds() async {
    String apiKey = await loadApikey();
    String path =
        "/weather/history/by-lat-lng?lat=12&lng=77&from=2020-11-03 00:00:00&to=2020-12-04 00:00:00";

    String url = _weatherBaseUrl + path;
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json', 'x-api-key': apiKey},
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  static Future<String> loadApikey() async {
    String config = await rootBundle.loadString('assets/config.txt');
    String apiKey = config.trim().split("=")[1];
    return apiKey;
  }
}
