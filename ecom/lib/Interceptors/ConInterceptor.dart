import 'package:dio/dio.dart';
import 'package:ecom/Services/Store.dart';

class ConInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    final token = await Store.getToken();
    if(token != null && token.isNotEmpty){
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }

}