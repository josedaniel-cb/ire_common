import 'package:flutter/material.dart';

class JdInkWell extends StatelessWidget {
  final void Function()? onTap;
  final void Function(TapUpDetails)? onTapUp;
  final void Function(TapDownDetails)? onTapDown;
  final Widget child;
  final bool behind;

  const JdInkWell({
    super.key,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.behind = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/q/45424621/11026079
    // https://stackoverflow.com/a/48066835/11026079

    return Stack(
      children: behind
          ? [
              child,
              _buildInkWell(),
            ]
          : [
              _buildInkWell(),
              child,
            ],
    );
  }

  Widget _buildInkWell() {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // highlightColor: Colors.pinkAccent,
          // splashColor: Colors.greenAccent,
          onTap: onTap,
          onTapUp: onTapUp,
          onTapDown: onTapDown,
        ),
      ),
    );
  }
}
