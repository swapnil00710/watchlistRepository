import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  static Future<List<dynamic>> getMarkets() async {
    try {
      Uri requestUri = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false");

      var response = await http.get(requestUri);
      var decodedResp = jsonDecode(response.body);

      List<dynamic> markets = decodedResp as List<dynamic>;

      return markets;
    } catch (ex) {
      return [];
    }
  }
}
