import 'package:flutter/material.dart';

import 'breakpoints.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext, BoxConstraints) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: builder);
  }

  static Widget breakpoint({
    required Widget Function(Breakpoint) builder,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var breakpoint = Breakpoint.sm;
        if (constraints.maxWidth >= Breakpoint.xxl.minWidth) {
          breakpoint = Breakpoint.xxl;
        } else if (constraints.maxWidth >= Breakpoint.xl.minWidth) {
          breakpoint = Breakpoint.xl;
        } else if (constraints.maxWidth >= Breakpoint.lg.minWidth) {
          breakpoint = Breakpoint.lg;
        } else if (constraints.maxWidth >= Breakpoint.md.minWidth) {
          breakpoint = Breakpoint.md;
        }
        return builder(breakpoint);
      },
    );
  }

  static Widget device({
    required Widget desktop,
    required Widget tablet,
    required Widget mobile,
  }) {
    return ResponsiveBuilder.breakpoint(
      builder: (breakpoint) {
        switch (breakpoint) {
          case Breakpoint.xxl:
          case Breakpoint.xl:
          case Breakpoint.lg:
            return desktop;
          case Breakpoint.md:
            return tablet;
          case Breakpoint.sm:
            return mobile;
        }
      },
    );
  }

  static Widget screenOrientation({
    required Widget portrait,
    required Widget landscape,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        if (size.width / size.height > 1) {
          return landscape;
        }
        return portrait;
      },
    );
  }
}
