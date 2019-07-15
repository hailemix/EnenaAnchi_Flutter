import 'package:enena_anchi/flip_navigation/flip_bar_element.dart';
import 'package:enena_anchi/flip_navigation/flip_bar_item.dart';
import 'package:flutter/cupertino.dart';

class FlipBoxBar extends StatefulWidget {

  final List<FlipBarItem> items;
  final Duration animationDuration;
  final ValueChanged<int> onIndexChanged;
  final int selectedIndex;
  final double navBarHeight;

  FlipBoxBar(
    {
     @required this.items,
     this.animationDuration = const Duration(milliseconds: 100),
     @required this.onIndexChanged,
     @required this.selectedIndex,
     this.navBarHeight = 80.0
    }
  );
  
  @override
  _FlipBoxBarState createState() => _FlipBoxBarState();
}

class _FlipBoxBarState extends State<FlipBoxBar> with TickerProviderStateMixin {

  List<AnimationController> _controllers = [];

  @override
  void initState() {
    super.initState();

    for(int i = 0; i < widget.items.length; i++){
      _controllers.add(
        AnimationController(
          vsync: this,
          duration: widget.animationDuration   
           )
      );
    }
    _controllers[widget.selectedIndex].forward();
  }
  @override
  Widget build(BuildContext context) {
    _changeValue();
    return Container(
      height: 80,
      child: Row(
        children: widget.items.map((item){
          int index = widget.items.indexOf(item);
          return Expanded(
            child: FlipBarElement(
              item.icon,
              item.text,
              item.fontColor,
              item.backColor,
              _controllers[index],
              (index){
                _changeValue();
                widget.onIndexChanged(index);
              },
              index,
              widget.navBarHeight,

            ),
          );
        }).toList(),
      ),
    );
  }

  void _changeValue(){
    _controllers.forEach((controller) => controller.reverse());
    _controllers[widget.selectedIndex].forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controllers.forEach((controller) => controller.dispose());
  }
}