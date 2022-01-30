import 'package:flutter/material.dart';

class BreathAnimation extends StatefulWidget {
  final Widget child;

  BreathAnimation({required this.child}) : assert(child != null);
  @override
  _BreathAnimationState createState() => _BreathAnimationState();
}

class _BreathAnimationState extends State<BreathAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    _scaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController));

    _animationController.repeat(reverse: true);
    //_animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          alignment: Alignment.center,
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
