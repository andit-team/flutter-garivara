import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DBHelper{

  static final Dio dio = Dio();

  static final String api = DotEnv().env['API_URL'];

  static final String createUser = DotEnv().env['createUser'];
  static final String loginUser = DotEnv().env['loginUser'];
}