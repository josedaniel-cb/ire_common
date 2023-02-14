import 'package:flutter/material.dart';

_setDivider(Iterable<Widget> iterable, Widget divider) {
  final list = iterable.toList();

  if (list.length <= 1) {
    return list;
  }

  final newList = [list[0]];
  for (var i = 1; i < list.length; i++) {
    newList.addAll([
      divider,
      list[i],
    ]);
  }

  return newList;
}

extension WidgetIterableExtensions on Iterable<Widget> {
  List<Widget> gap(double value) {
    return _setDivider(
      this,
      SizedBox(
        height: value,
        width: value,
      ),
    );
  }

  List<Widget> divider(Widget divider) {
    return _setDivider(this, divider);
  }
}
