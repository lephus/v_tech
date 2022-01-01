import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedContainerApp extends StatefulWidget {
  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
}
class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  double _width = 150;
  double _height = 100;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => _getTime());
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
    timer = null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
        body: Center(
          child: AnimatedContainer(
            // Use the properties stored in the State class.
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
            ),
            // Define how long the animation should take.
            duration: Duration(seconds: 1),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.fastOutSlowIn,
          ),
        ),
    );
  }
  void _getTime() {
    setState(() {
      // Create a random number generator.
      final random = Random();
      // Generate a random width and height.
      _width = random.nextInt(50).toDouble()+150;
      _height = random.nextInt(50).toDouble()+100;
      // Generate a random color.
      _color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
      // Generate a random border radius.
      _borderRadius =
          BorderRadius.circular(random.nextInt(10).toDouble());
    });
  }
}