
import 'package:dio/dio.dart';
import 'package:fluttertalk03/core/utils/toast_utils.dart';
import '../config/endpoint.dart';
import '../models/auth_model.dart';

class AuthServices {

  static Dio dio = new Dio();
  
  static Future<AuthModel> register(Map registerData) async {
    try{
      var response = await dio.post(
        Endpoint.register,
        data: FormData.fromMap(registerData),
        options: Options(headers: {"Accept": "application/json"})
      );
      return AuthModel.fromJson(response.data);
    }catch(e){
      print ("ERRR: " + e.toString());
      ToastUtils.show("Please check your connection");
    }
  }

   static Future<AuthModel> login(Map loginData) async {
    try{
      var response = await dio.post(
        Endpoint.login,
        data: FormData.fromMap(loginData),
        options: Options(headers: {"Accept": "application/json"})
      );
      return AuthModel.fromJson(response.data);
    }catch(e){
      print ("ERRR: " + e.toString());
      ToastUtils.show("Please check your connection");
    }

  }
}