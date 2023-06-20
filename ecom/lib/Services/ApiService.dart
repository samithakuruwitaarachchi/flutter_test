import 'dart:convert';
import 'dart:developer';

import 'package:ecom/Models/ModelProducts.dart';
import 'package:ecom/constants/Apis.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ecom/Services/Store.dart';
import 'package:ecom/Interceptors/ConInterceptor.dart';

class ApiService {
  late final Dio _dio;
  ApiService(){
    _dio = Dio();
    _dio.interceptors.add(ConInterceptor());
  }

  Map<String, dynamic> get _loginData  => {
    "email":"",
    "password":"",
  };

  Future<void> _saveToken(Map<String, dynamic> data ) async{
    final token = data["access_token"];
    final rToken = data["refresh_token"];
    await Store.setToken(token);
    await Store.setRefreshToken(rToken);
  }

  Future<bool> doLogin(em, pass) async{

    var params = {
      "email":em,
      "password":pass,
    };

    final response = await _dio.post(
      Apis.authUrl,
      data: jsonEncode(params)
    );

    if(response.statusCode == 201){
      await _saveToken(response.data);
      return true;
    }

    return false;
  }

  Future<List<dynamic>?> getProdData(pg) async {
    try{

      final resposnse = await _dio.get(
        Apis.baseUrl + "/recommend/items?page={$pg}",
      );
      if(resposnse.statusCode == 200){
        List<dynamic> list = _getResults(resposnse.data);
        return list;
      }

    }on DioError catch(e){
      // return "Error accured";
    }
  }

  Future getSingleProdData(pid) async {
    try{

      final resposnse = await _dio.get(
        Apis.baseUrl + Apis.getProductDetail + "{$pid}",
      );

      if(resposnse.statusCode == 200){

        final list = resposnse.data;

        //print("135454364354343 :: $list");
        return list;
      }else{
        throw Exception('Unexpected error occured!');
      }

    }catch(e){
      // return "Error accured";
    }
  }


  List<dynamic> _getResults(Map<String, dynamic> json){
    log("data prod" + json.toString());
    final List<dynamic> list = json['data']['products'];
    return list;
  }

  List _getProductResults(Map<String, dynamic> json){
    log("data product" + json.toString());
    final list = json['data']['product'];
    print("khgfhsgf:: $list");
    return list;
  }
}