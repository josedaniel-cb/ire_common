import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({Key? key, this.fontSize}) : super(key: key);

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      'latin_library',
      style:
          Theme.of(context).textTheme.headline3?.copyWith(fontSize: fontSize),
    );
  }
}
