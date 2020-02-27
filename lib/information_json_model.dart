import 'dart:convert';

import 'package:flutter/services.dart';

class InformationJsonContent {
  List<String> allContents;

  InformationJsonContent({this.allContents});

  factory InformationJsonContent.fromJson(Map<String, dynamic> parsedJson) {
    List<String> fullContents = parsedJson['allInfoContents'].cast<String>();

    return InformationJsonContent(allContents: fullContents);
  }
}

Future<String> _loadContents() async {
  return await rootBundle.loadString('jsonStore/bestContents.json');
}

Future<InformationJsonContent> loadInformationContent() async {
  String jsonString = await _loadContents();
  final jsonResponse = json.decode(jsonString);
  return InformationJsonContent.fromJson(jsonResponse);
}
