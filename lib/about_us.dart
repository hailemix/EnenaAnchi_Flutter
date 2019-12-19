import 'dart:math';
import 'package:enena_anchi/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FancyBackgroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child: AnimatedBackground()),
        onBottom(AnimatedWave(
          height: 180,
          speed: 1.0,
        )),
        onBottom(AnimatedWave(
          height: 120,
          speed: 0.9,
          offset: pi,
        )),
        onBottom(AnimatedWave(
          height: 220,
          speed: 1.2,
          offset: pi / 2,
        )),
        Center(
          child:Container(
          width: 260,
          height: 180,
          decoration: BoxDecoration(
            
            border: Border.all(style: BorderStyle.solid,color: Colors.white),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10.0))
            ) ,
          child:Center(
            child: Container(
              width: 250,
              height: 170,
              decoration: BoxDecoration(

                  border: Border.all(style: BorderStyle.solid,color: Colors.white),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(7.0))
              ) ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  myTextWidget('ዲቨሎፐር',40.0),
                  myTextWidget('ኤ.ኤፍ.ሲ ኢትዮጲያ', 20.0),
                  myTextWidget('hailemix2@gmail.com', 20.0)
                ],
              ),
            ),
          )
          ),
        ),

        Positioned(
          top: 30,
          left: 5,
          child: CupertinoButton(
            child: Icon(
              CupertinoIcons.home,
              color: CupertinoColors.black,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context, AboutUsBackRoute(builder: (context) => HomeClass()));
            },
          ),
        )

        ]
    );
  }

 myTextWidget(String child, double myFontSize) {
  return Material(
    type: MaterialType.transparency,
      child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        child,
        style: TextStyle(fontSize:myFontSize,color: Colors.white,fontFamily: 'Nyala'),
      ),
    ),
  );
 }
  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );

}

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  AnimatedWave({this.height, this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xffD38312), end: Colors.lightBlue.shade900)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xffA83279), end: Colors.blue.shade600))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}


class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  FancyBackgroundApp();
  }
}

class AboutUsBackRoute<T> extends MaterialPageRoute<T> {
  AboutUsBackRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}