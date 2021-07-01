
//TODO: TEST IF DIO SENDS REQUEST AND RETURNS  A MAP

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

main () {

  Future testDio()async{
    int number = new Random().nextInt(10);
    Dio dio = Dio();
    String url = "https://jsonplaceholder.typicode.com/users" + "/$number";

      Response response = await dio.get(
        url,
      );
      return response.data;

  }
  test("Dio should return a  map", ()async{
    //Arrange
    Map expectedValue={};
    var testD = await testDio();

    //Assert
    expect(expectedValue.runtimeType, testD.runtimeType);
  });
}