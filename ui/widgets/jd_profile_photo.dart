import 'dart:async';

import 'package:flutter/material.dart';

import 'jd_network_image.dart';

class JdProfilePhoto extends StatefulWidget {
  final void Function()? onTap;
  final String name;
  final String? url;
  final double fontSize;
  final bool shadow;

  const JdProfilePhoto({
    super.key,
    this.onTap,
    required this.name,
    this.url,
    this.fontSize = 17.5,
    this.shadow = true,
  });

  @override
  State<JdProfilePhoto> createState() => _JdProfilePhotoState();
}

class _JdProfilePhotoState extends State<JdProfilePhoto> {
  Timer? _timer;
  var _isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.fontSize * 2.5;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: widget.shadow
            ? [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: widget.fontSize * 0.1,
                  spreadRadius: 0,
                )
              ]
            : null,
      ),
      child: ClipOval(
        child: SizedBox(
          height: size,
          width: size,
          child: GestureDetector(
            onTapDown: (_) => _highlight(),
            onTap: widget.onTap,
            child: widget.url != null
                ? JdNetworkImage(
                    url: widget.url!,
                    errorChild: _buildDefault(),
                  )
                : _buildDefault(),
          ),
        ),
      ),
    );
  }

  void _highlight() {
    _timer?.cancel();
    setState(() => _isHighlighted = true);
    _timer = Timer(
      const Duration(milliseconds: 200),
      () => setState(() => _isHighlighted = false),
    );
  }

  Widget _buildDefault() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOutCubic,
      color: _isHighlighted && widget.onTap != null
          ? Colors.orange.shade200
          : Colors.orange.shade600,
      alignment: Alignment.center,
      child: Text(
        widget.name
            .split(' ')
            .where((word) => word.isNotEmpty)
            .take(2)
            .map((word) => word[0])
            .join(),
        style: TextStyle(
          color: Colors.white,
          fontSize: widget.fontSize,
        ),
      ),
    );
  }
}
