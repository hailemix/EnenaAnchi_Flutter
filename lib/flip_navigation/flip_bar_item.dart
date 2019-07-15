import 'package:flutter/cupertino.dart';

class FlipBarItem {
  
  final Widget icon;
  final Widget text;
  final Color fontColor;
  final Color backColor;

  FlipBarItem({
    @required this.icon,
    @required this.text,
    this.fontColor = CupertinoColors.activeBlue,
    this.backColor = CupertinoColors.activeOrange,
  });
}