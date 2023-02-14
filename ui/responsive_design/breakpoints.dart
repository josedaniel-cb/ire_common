/// https://tailwindcss.com/docs/screens
enum Breakpoint {
  sm(minWidth: 640),
  md(minWidth: 768),
  lg(minWidth: 1024),
  xl(minWidth: 1280),
  xxl(minWidth: 1536);

  const Breakpoint({required this.minWidth});

  final double minWidth;
}
