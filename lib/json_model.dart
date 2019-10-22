import 'dart:convert';
import 'package:flutter/services.dart';

class JsonContent {

  List<String> contentOne;
  List<String> contentTwo;
  List<String> contentThree;
  JsonContent({this.contentOne,this.contentTwo,this.contentThree});

  factory JsonContent.fromJson(Map<String, dynamic> parsedJson){

 List<String> contentOneData = parsedJson['forHer'].cast<String>();
 List<String> contentTwoData = parsedJson['forHim'].cast<String>();
 List<String> contentThreeData = parsedJson['mixed'].cast<String>();
     return JsonContent(
       contentOne: contentOneData,
       contentTwo: contentTwoData,
       contentThree: contentThreeData
     );
  }
  
}

Future<String>  _loadContents() async {
return await rootBundle.loadString('jsonStore/enenaAnchi.json');
}

Future<JsonContent> loadContent() async {
   await _wait(200);
  String jsonString = await _loadContents();
  final jsonResponse = json.decode(jsonString);
  return JsonContent.fromJson(jsonResponse);

}

Future _wait(int millisecond) {
  return Future.delayed(Duration(milliseconds: millisecond),() => {});
}





