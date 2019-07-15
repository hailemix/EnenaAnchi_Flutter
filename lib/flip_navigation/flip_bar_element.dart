import 'package:enena_anchi/flip_navigation/flip_box.dart';
import 'package:flutter/cupertino.dart';

class FlipBarElement extends StatelessWidget {

  final Widget icon;
  final Widget text;
  final Color frontColor;
  final Color backColor;
  final AnimationController controller;
  final ValueChanged<int> onTapped;
  final index;
  final double appBarHeight;

  FlipBarElement(this.icon,this.text,this.frontColor,this.backColor,
  this.controller,this.onTapped,this.index,this.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return FlipBox(
      bottomChild: Container(
        width: double.infinity,
        height: double.infinity,
        color: backColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            text
          ],
        ),
      ),
      topChild: Container(
        width: double.infinity,
        height: double.infinity,
        color: frontColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
          ],
        ),
      ),
      onTapped: (){
        onTapped(index);
      },
      height: appBarHeight,
    );
  }
}