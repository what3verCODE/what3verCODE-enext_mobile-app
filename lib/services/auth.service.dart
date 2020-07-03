import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  HttpClient _httpClient;
  String _baseUrl;
  SharedPreferences _sharedPreferences;

  AuthService() { 
    _httpClient = new HttpClient();
    _httpClient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true); 
    _baseUrl = 'https://77.73.70.61/identity/';
    _initSharedPreferences();
  }

  _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> login(String email, password) async {
    Map data = {
      'email': email,
      'password': password
    };

    var url = _baseUrl + 'login';
    HttpClientRequest request = await _httpClient.postUrl(Uri.parse(url));

    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(data)));

    HttpClientResponse response = await request.close();

    String reply = await response.transform(utf8.decoder).join();

    return true;
  }

  Future<bool> register(String email,password) async {
    Map data = {
      'email': email,
      'password': password
    };

    var url = _baseUrl + 'login';
    HttpClientRequest request = await _httpClient.postUrl(Uri.parse(url));

    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(data)));

    HttpClientResponse response = await request.close();

    String reply = await response.transform(utf8.decoder).join();

    return true;
  }
}