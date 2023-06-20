import 'dart:convert';
import 'dart:developer';

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

  Future<String?> getProdData() async {
    try{

      final resposnse = await _dio.get(
        Apis.baseUrl + "/recommend/items?page={1}",
      );
      if(resposnse.statusCode == 200){
        return _getResults(resposnse.data);
      }

    }on DioError catch(e){
      return "Error accured";
    }
  }

  String _getResults(Map<String, dynamic> json){
    log("data prod" + json.toString());
    final List<dynamic> list = json['data'];
    return 'Received ${list.length} objects';


  }
}