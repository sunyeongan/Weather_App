
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network{
  final String url;
  final String url2;

  Network(this.url,this.url2);

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url)); //http 버전이 업그레이드 돼서 URI를 사용해야 함.
    if (response.statusCode == 200) { //http 연결이 성공하면
      String jsonData = response.body; //Json 데이터 불러오기

      var parsingData = jsonDecode(jsonData);

      return parsingData;
    }
  }

  Future<dynamic> getAirData() async {
    http.Response response = await http.get(Uri.parse(url2)); //http 버전이 업그레이드 돼서 URI를 사용해야 함.
    if (response.statusCode == 200) { //http 연결이 성공하면
      String jsonData = response.body; //Json 데이터 불러오기

      var parsingData = jsonDecode(jsonData);

      return parsingData;
    }
  }
}