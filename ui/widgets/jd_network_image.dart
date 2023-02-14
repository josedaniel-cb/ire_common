import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Widget _defaultOnLoading(
//   ImageChunkEvent loadingProgress,
// ) {
//   return Center(
//     child: CircularProgressIndicator(
//       value: loadingProgress.expectedTotalBytes != null
//           ? loadingProgress.cumulativeBytesLoaded /
//               loadingProgress.expectedTotalBytes!
//           : null,
//     ),
//   );
// }

// Widget _defaultOnReady(
//   Widget child,
// ) {
//   return child;
// }

class JdNetworkImage extends StatelessWidget {
  final String url;
  // final Widget? loadingChild;
  final Widget errorChild;
  // final Widget Function(ImageChunkEvent loadingProgress) onLoading;
  // final Widget Function(Widget child) onReady;
  // final double? aspectRatio;

  const JdNetworkImage({
    super.key,
    required this.url,
    // this.onLoading = _defaultOnLoading,
    // this.onReady = _defaultOnReady,
    // this.aspectRatio,
    required this.errorChild,
    // this.loadingChild,
  });

  @override
  Widget build(BuildContext context) {
    // if (aspectRatio == null) {
    //   return _buildImage();
    // }
    // return AspectRatio(
    //   aspectRatio: aspectRatio!,
    //   child: _buildImage(),
    // );
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: url,
      progressIndicatorBuilder: (context, url, download) {
        return Center(
          child: CircularProgressIndicator(value: download.progress),
        );
      },
      errorWidget: (context, url, error) => errorChild,
    );
  }

  // Widget _buildImage() {
  //   return Image.network(
  //     url,
  //     fit: BoxFit.cover,
  //     loadingBuilder: (
  //       BuildContext context,
  //       Widget child,
  //       ImageChunkEvent? loadingProgress,
  //     ) {
  //       if (loadingProgress == null) return onReady(child);
  //       return onLoading(loadingProgress);
  //     },
  //     frameBuilder: (
  //       BuildContext context,
  //       Widget child,
  //       int? frame,
  //       bool wasSynchronouslyLoaded,
  //     ) {
  //       if (wasSynchronouslyLoaded) return onReady(child);
  //       return AnimatedOpacity(
  //         opacity: frame == null ? 0 : 1,
  //         duration: const Duration(seconds: 1),
  //         curve: Curves.easeOut,
  //         child: onReady(child),
  //       );
  //     },
  //   );
  // }

}
