import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class ContainerWidget extends AnimatedWidget{


  final Widget theContainer;
  final Color zColor;
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  static final _heightTween = Tween<double>(begin: 0, end: 550);
  static final _widthTween = Tween<double>(begin: 0,end: 350);

  ContainerWidget({Key key,this.theContainer,Animation<double> animation,this.zColor}) : super(key:key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
         width: _widthTween.evaluate(animation),
         height: _heightTween.evaluate(animation),
        decoration: BoxDecoration(
            color: zColor,
            border: Border.all(color: Colors.white,style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            shape: BoxShape.rectangle
        ),
        child:theContainer ,
      ),
    );
  }
}

