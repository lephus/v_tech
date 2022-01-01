import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
enum AniProps { x, y }
class FadeAnimation extends StatelessWidget {
  final int delay;
  final Widget childWidget;
  FadeAnimation(this.delay, this.childWidget);
  @override
  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      tween: Tween(begin: -500.0, end: 0.0),
      delay: Duration(seconds: delay),// value for offset x-coordinate
      duration: const Duration(seconds: 2),
      curve: Curves.easeInBack, // non-linear animation
      builder: (context, child, value) {
        return Transform.translate(
          offset: Offset(value, 0), // use animated value for x-coordinate
          child: child,
        );
      },
      child: childWidget
    );
  }
}