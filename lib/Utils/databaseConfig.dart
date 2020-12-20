import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DBHelper{
  static final BaseOptions options = new BaseOptions(
    baseUrl: DotEnv().env['API_URL'],
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  static final Dio dio = Dio(options);

  static final String api = DotEnv().env['API_URL'];

  static final String createUser = DotEnv().env['createUser'];
  static final String loginUser = DotEnv().env['loginUser'];
}