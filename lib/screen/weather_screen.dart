
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/model.dart';

class WeatherScreen extends StatefulWidget {

  WeatherScreen({this.parseWeatherData,this.parseAirPollution}); //생성자
  final dynamic parseWeatherData; //다양한 타입의 날씨 데이터를 받기 때문에 데이터 타입을 dynamic으로 지정함.
  final dynamic parseAirPollution;
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  String cityName =''; //null safety로 선언만 불가능해서 임의의 값으로 초기화함.
  int temp = 0;
  Widget? icon2;
  String weather_script='';


  Widget? airIcon; //aqi 아이콘
  Widget? airState;// aqi 상태 이미지

  double dst1 = 0.0;
  double dst2 = 0.0;

  var date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData,widget.parseAirPollution);
  }

  void updateData(dynamic weatherData, dynamic airData){
    //Json 데이터 파싱하기


      double temp2 = weatherData['main']['temp'];
      int condition = weatherData['weather'][0]['id'];
      int air_index =  airData['list'][0]['main']['aqi'];

      weather_script = weatherData['weather'][0]['description']; //날씨 부가설명
      temp = temp2.toInt(); // double 으로 표현되는 온도를 int형으로 바꿈
      //temp = temp2.round(); //소수점 이하는 버림.
      cityName = weatherData['name'];

      dst1 = airData['list'][0]['components']['pm10'].toDouble();
      dst2 = airData['list'][0]['components']['pm2_5'].toDouble();

      icon2 = model.getWeatherIcon(condition);//날씨 아이콘
      airIcon = model.getAirIcon(air_index);
      airState = model.getAirCondition(air_index);



      print(temp);
      print(cityName);

  }

  String getSystemTime(){
    var now = DateTime.now();
    return DateFormat("h시 mm분 a").format(now);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //body를 appbar까지 확장함
      appBar: AppBar(
        //title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,//음영 0으로 설정.
        leading: IconButton( //좌측 상단 아이콘
          icon : Icon(Icons.near_me),
          onPressed: () {},
          iconSize: 30.0,
        ),
        actions: [ //우측 상단 아이콘
          IconButton(
            icon : Icon(
              Icons.location_searching,
            ),
            onPressed: () {},
            iconSize: 30.0,
          )
        ],
      ),
      body : Container(
        child : Stack(
          children: [
            Image.asset('image/background.jpg',
            fit : BoxFit.cover,
              width : double.infinity,
              height : double.infinity,
            ),
            Container(
              padding : EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start, //align
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start, //align
                          children: [
                            SizedBox(
                              height: 150.0,
                            ),
                            Text(
                              '$cityName',
                              style : GoogleFonts.lato(
                                fontSize : 35.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            ),
                            Row(//시간, 날짜 표현
                              children: [
                                TimerBuilder.periodic(
                                  (Duration(minutes: 1)),
                                  builder: (context){
                                    print('${getSystemTime()}');
                                    return Text(
                                      '${getSystemTime()}',
                                      style: GoogleFonts.lato(
                                        fontSize: 16.0,
                                        color : Colors.white
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  DateFormat(' - EEEE, ').format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0,
                                      color : Colors.white
                                  )
                                ),
                                Text(
                                  DateFormat('d MMM, yyy').format(date),
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0,
                                        color : Colors.white
                                    )
                                ),
                              ],
                            )
                          ],
                        ),
                        Column( //온도 컬럼
                          crossAxisAlignment: CrossAxisAlignment.start, //기온 좌측 정렬

                          children: [
                            Text(
                              '$temp\u2103',
                              style : GoogleFonts.lato(
                                fontSize : 85.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),

                            ),
                            Row(
                              children: [
                                icon2!,
                                SizedBox(
                                  width : 10.0,

                                ),
                                Text('$weather_script',
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0,
                                      color : Colors.white),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider( //구분선
                        height: 15.0,
                        thickness: 2.0,
                        color: Colors.white30,

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, //Column1,2,3 width 간격 자동조절
                        children: [
                          Column( //Column 1
                            children: [
                              Text(
                                'AQI(대기질지수)',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color : Colors.white),
                              ),
                              SizedBox( // 간격 조정
                                height : 10.0,
                              ),
                              airIcon!,
                              SizedBox(// 간격 조정
                                height : 10.0,
                              ),
                              airState!,
                            ],
                          ),
                          Column( //Column2
                            children: [
                              Text(
                                '미세먼지',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color : Colors.white),
                              ),
                              SizedBox( // 간격 조정
                                height : 10.0,
                              ),
                              Text(
                                '$dst1',
                                style: GoogleFonts.lato(
                                    fontSize: 24.0,
                                    color : Colors.white),
                              ),
                              SizedBox(// 간격 조정
                                height : 10.0,
                              ),
                              Text(
                                '㎍/m³',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color : Colors.white,
                                    fontWeight : FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          Column(//column3
                            children: [
                              Text(
                                '초미세먼지',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color : Colors.white),
                              ),
                              SizedBox( // 간격 조정
                                height : 10.0,
                              ),
                              Text(
                                '$dst2',
                                style: GoogleFonts.lato(
                                    fontSize: 24.0,
                                    color : Colors.white),
                              ),
                              SizedBox(// 간격 조정
                                height : 10.0,
                              ),
                              Text(
                                '㎍/m³',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color : Colors.white,
                                    fontWeight : FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )

          ],
          
        ),
      ),
    );
  }
}
