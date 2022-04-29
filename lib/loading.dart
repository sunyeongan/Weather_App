
import 'package:flutter/material.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screen/weather_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '4981aff24382e74f51f3cb8b4e69ac92';


class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  double latitude3 = 0.0;
  double longtitude3 = 0.0;
  @override
  void initState() {//로딩화면 호출시 1번만 호출되는 메서드
    // TODO: implement initState
    super.initState();
    getLocation(); //로딩화면 생성시 getLocation() 1번 호출

  }

  void getLocation() async{ //async , await , 위치를 불러와서 positon에 저장

    MyLocation myLocation = MyLocation();//myLocation 인스턴스 생성
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longtitude3  = myLocation.longtitude2;

    print(latitude3);
    print(longtitude3);

    Network network = Network('https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longtitude3&appid=$apiKey&units=metric',
    'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longtitude3&appid=$apiKey');

    var weatherData = await network.getJsonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    Navigator.push(context,MaterialPageRoute(builder: (context){
      return WeatherScreen(
        parseWeatherData: weatherData,
        parseAirPollution: airData,
      ); //WeatherScreen에게 파싱한 날씨데이터 전달
    }));
  }

  /*void fetchData() async{

      //Json 데이터 파싱하기
      var myJson = parsingData['weather'][0]['description']; //JsonDecode 데이터 타입은 Dynamic, 그래서 var 키쿼드를 이용해 변수 선언
      print(myJson);

      var wind = parsingData['wind']['speed'];
      print(wind);

      var id = parsingData['id'];
      print(id);
    }else{
      print(response.statusCode);
    }

  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size : 80.0,
        )
      )
    );
  }
}
