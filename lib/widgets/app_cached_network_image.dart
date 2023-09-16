// import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ImageType { network, file, asset }

class AppImageWidget extends StatelessWidget {
  const AppImageWidget({
    Key? key,
    required this.asset,
    this.height,
    this.width,
    this.fit = BoxFit.fitHeight,
    this.allowToViewImage = false,
  }) : super(key: key);

  final String? asset;
  final double? height;
  final double? width;
  final BoxFit fit;
  final bool allowToViewImage;

  @override
  Widget build(BuildContext context) {
    switch (_getImageType(asset ?? "")) {
      case ImageType.network:
        return AbsorbPointer(
          absorbing: !allowToViewImage,
          child: GestureDetector(
            onTap: () => _openImageViewer(asset ?? ""),
            child: CachedNetworkImage(
              imageUrl: asset ?? "",
              height: height,
              width: width,
              fit: fit,
              progressIndicatorBuilder: (context, url, progress) {
                return Center(
                  child: CircularProgressIndicator(
                    value: progress.totalSize != null
                        ? progress.downloaded / progress.totalSize!
                        : 0,
                  ),
                );
              },
            ),
          ),
        );

      /// Due to web platform, commented the File type
      /*case ImageType.file:
        return AbsorbPointer(
          absorbing: !allowToViewImage,
          child: GestureDetector(
            onTap: () => _openImageViewer(asset ?? ""),
            child: Image.file(
              File(asset ?? ""),
              fit: fit ?? BoxFit.fitWidth,
              height: height,
              width: width,
            ),
          ),
        );*/
      case ImageType.asset:
        return AbsorbPointer(
          absorbing: !allowToViewImage,
          child: GestureDetector(
            onTap: () => _openImageViewer(asset ?? ""),
            child: Image.asset(
              asset ?? "",
              fit: fit,
              height: height,
              width: width,
            ),
          ),
        );
    }
    return CachedNetworkImage(
      imageUrl: asset ?? "",
      height: height,
      width: width,
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: CircularProgressIndicator(
            value: progress.totalSize != null
                ? progress.downloaded / progress.totalSize!
                : 0,
          ),
        );
      },
    );
  }

  ImageType _getImageType(String imagePath) {
    /// Due to web platform, commented the File type
    // if (File(imagePath).existsSync()) return ImageType.file;
    if (Uri.parse(imagePath).isAbsolute) return ImageType.network;
    return ImageType.asset;
  }

  void _openImageViewer(String asset) {
    Get.to(() => ImageViewerScreen(asset: asset));
  }
}

class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({Key? key, required this.asset}) : super(key: key);
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppImageWidget(
          asset: asset,
        ),
      ),
    );
  }
}
