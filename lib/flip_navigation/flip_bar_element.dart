import 'package:enena_anchi/contentTwo.dart';
import 'package:enena_anchi/flip_navigation/flip_box.dart';
import 'package:enena_anchi/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlipBarElement extends StatefulWidget {

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
  _FlipBarElementState createState() => _FlipBarElementState();
}

class _FlipBarElementState extends State<FlipBarElement> {

  Widget nextPage;
  @override
  Widget build(BuildContext context) {
    return FlipBox(
      bottomChild: Container(
        width: double.infinity,
        height: double.infinity,
        color: widget.backColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.icon,
            widget.text
          ],
        ),
      ),
      topChild: Container(
        width: double.infinity,
        height: double.infinity,
        color: widget.frontColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.icon,
          ],
        ),
      ),
      onTapped: (){
        widget.onTapped(widget.index);
         Navigator.push(context, MaterialPageRoute(builder: (context){  
                      if (widget.index == 0 || widget.index == 2) {
                        nextPage = MyApp();
                      } else if (widget.index == 1){
                        nextPage = ContentTwo();
                      }
                   return nextPage;
                  }
                   ));
      },
      height: widget.appBarHeight,
    );
  }
}