import 'package:flutter/material.dart';

import 'jd_inkwell.dart';

class JdIconButton extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final double padding;

  const JdIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.padding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: JdInkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(padding),
          color: Colors.blue,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
