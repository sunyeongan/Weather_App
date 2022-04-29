
import 'package:geolocator/geolocator.dart';

class MyLocation{
  double latitude2 = 0.0;//null safety 로 인해 0.0으로 초기화
  double longtitude2 = 0.0;

  Future<void> getMyCurrentLocation() async{
    try{
      LocationPermission permission = await Geolocator.requestPermission(); //denied permissions to  error 해결
      Position position = await Geolocator.//위도, 경도 정보 할당
      getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longtitude2 = position.longitude;
      print(latitude2);
      print(longtitude2);
    }catch(e){
      print('인터넷 연결에 문제가 생겼습니다.');
    }
  }
}