import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _a1;
  late final Animation<double> _a2;
  late final Animation<double> _a3;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat();
    _a1 = CurvedAnimation(
        parent: _c, curve: const Interval(0.0, 0.6, curve: Curves.easeInOut));
    _a2 = CurvedAnimation(
        parent: _c, curve: const Interval(0.2, 0.8, curve: Curves.easeInOut));
    _a3 = CurvedAnimation(
        parent: _c, curve: const Interval(0.4, 1.0, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget dot(Animation<double> a) => ScaleTransition(
        scale: a,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: CircleAvatar(radius: 4),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [dot(_a1), dot(_a2), dot(_a3)],
    );
  }
}
