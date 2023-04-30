import "package:arsipdian/models/user.dart";
import "package:arsipdian/services/dio.dart";
import "package:dio/dio.dart" as Dio;
import "package:flutter/material.dart";



class Auth extends ChangeNotifier{
  bool _isLoggedIn = false;
  User? _user;
  String? token;

  bool get authenticated => _isLoggedIn;
  User? get user => _user;

  void login({required Map creds}) async {
    print(creds);

    try {
        Dio.Response response = await dio().post('/login', data: creds);
        print(response.data.toString());

        String token = response.data.toString();
        this.tryToken(token: token);

        _isLoggedIn = true;

        notifyListeners();
    }catch(e){
      print(e);
    }


  }

  void tryToken({required String token}) async {
    if (token == null){
      return;
    }else{
      try {
        Dio.Response response = await dio().get('/me', options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}));
        this._isLoggedIn = true;
        this._user = User.fromJson(response.data);
        notifyListeners();
        print(_user);
      }catch(e){
        print(e);
      }
    }
  }
  void logout(){
    _isLoggedIn = false;
    notifyListeners();
  }
}