import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class CoursesService {
  HttpClient _httpClient;
  String _baseUrl;
  SharedPreferences _sharedPreferences;

  CoursesService() {
    _httpClient = new HttpClient();
    _httpClient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    _baseUrl = 's';
  }
}