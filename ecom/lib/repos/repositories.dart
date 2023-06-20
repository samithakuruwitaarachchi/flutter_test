import 'dart:developer';

import 'package:ecom/Services/ApiService.dart';

class repositories {

  final apiService = ApiService();

 authUser(email, pass) async {

    print('attempting login');
    final res = await apiService.doLogin(email, pass);
    print("res **** : " + res.toString());

    return true;

  }

  Future<void> login() async {
    print('attempting login');
    await Future.delayed(Duration(seconds: 3));
    print('logged in');
    throw Exception('failed log in');
  }

}