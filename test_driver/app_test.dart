
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main(){

  group('Enena Anchi Flutter App', () {

    FlutterDriver driver;


    setUpAll(() async{
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if(driver != null){
        driver.close();
      }
    });
  });
}