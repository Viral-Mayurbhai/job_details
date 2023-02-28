import 'dart:async';
import 'package:http/http.dart' as http;

class JobDetailsApi {
  static Future getJobDetails() {
    return http.get(Uri.parse("https://devstaticapi.hire22.co/v1/jobdesignations"));
  }
}