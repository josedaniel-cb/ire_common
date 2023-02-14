import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class CellInformation {
  final bool firstColumn;
  final bool lastColumn;

  CellInformation({
    required this.firstColumn,
    required this.lastColumn,
  });
}

class JdExtentGridView extends StatelessWidget {
  final List<Widget> children;
  final double maxCrossAxisExtent;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final Widget Function(Widget child, CellInformation info)? builder;

  const JdExtentGridView({
    super.key,
    required this.children,
    required this.maxCrossAxisExtent,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount =
            (constraints.maxWidth / maxCrossAxisExtent).ceil();
        final mainAxisCount = (children.length / crossAxisCount).ceil();
        return LayoutGrid(
          columnSizes: List.filled(crossAxisCount, 1.fr),
          rowSizes: List.filled(mainAxisCount, auto),
          rowGap: mainAxisSpacing,
          columnGap: crossAxisSpacing,
          children: builder != null
              // ? children.map((e) {
              //     final info = CellInformation(

              //     );
              //     return builder!(e, info);
              //   }).toList()
              ? List.generate(children.length, (index) {
                  final columns = crossAxisCount;
                  final columnIndex = ((index + 1) % columns) - 1;
                  final info = CellInformation(
                    firstColumn: columnIndex == 0,
                    lastColumn: columnIndex == columns - 1,
                  );
                  return builder!(children[index], info);
                })
              : children,
        );
      },
    );
  }
}
