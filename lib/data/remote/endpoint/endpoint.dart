import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataEndpoint {
  DataEndpoint();

  String? url = dotenv.env['CURRENT_ENV'] == "0"
      ? dotenv.env['BASE_URL_DEV']
      : dotenv.env['BASE_URL'];
}

class Endpoints {
  Endpoints._();

  static const int receiveTimeout = 30;
  static const int connectionTimeout = 30;

  static String baseURL = DataEndpoint().url!;
}
