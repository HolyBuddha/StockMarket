import 'dart:convert';
import 'home_models.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  static const _apikey = "QQZLU6KEF2KXDOOJ";

  Future<List<CompanyInfo>> getAllCompaniesInfo(
      List<String> companyName) async {
    var responsesList = await Future.wait(companyName.map((name) => http.get(
        Uri.parse(
            'https://www.alphavantage.co/query?function=OVERVIEW&symbol=$name&apikey=$_apikey'))));

    return responsesList.map((response) {
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['Note'] != null) {
          throw Exception(jsonDecode(response.body)['Note']);
        }
        return CompanyInfo.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Response status ${response.statusCode}');
      }
    }).toList();
  }
}
