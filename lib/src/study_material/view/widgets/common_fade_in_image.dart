import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/utils/helpers/extensions.dart';

class CommonFadeInImage extends StatelessWidget {
  final String? image;
  final String? placeHolderImage;
  final BoxFit? fit;
  final BoxFit? placeholderFit;
  final Widget? imageErrorWidget;
  final Widget? placeholderErrorWidget;
  final double? height;
  final double? width;

  const CommonFadeInImage(
      {Key? key,
      required this.image,
      this.placeHolderImage,
      this.fit,
      this.placeholderFit,
      this.imageErrorWidget,
      this.placeholderErrorWidget,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: placeHolderImage ?? "",
      image: image ?? "",
      fit: fit ?? BoxFit.contain,
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      placeholderFit: placeholderFit ?? BoxFit.scaleDown,
      imageErrorBuilder: (_, __, ___) =>
          imageErrorWidget ?? const SizedBox.shrink(),
      placeholderErrorBuilder: (_, __, ___) =>
          placeholderErrorWidget ?? const SizedBox.shrink(),
    );
  }
}

class CommonFadeInImageWithCache extends StatelessWidget {
  final String? image;
  final String? placeHolderImage;
  final BoxFit? fit;
  final BoxFit? placeholderFit;
  final Widget? imageErrorWidget;
  final Widget? placeholderErrorWidget;
  final double height;
  final double width;

  const CommonFadeInImageWithCache(
      {Key? key,
      required this.image,
      this.placeHolderImage,
      this.fit,
      this.placeholderFit,
      this.imageErrorWidget,
      this.placeholderErrorWidget,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: placeHolderImage ?? "",
      image: image ?? "",
      fit: fit ?? BoxFit.contain,
      height: height,
      width: width,
      imageCacheWidth: context.cacheSize(width),
      imageCacheHeight: context.cacheSize(height),
      placeholderFit: placeholderFit ?? BoxFit.scaleDown,
      imageErrorBuilder: (_, __, ___) =>
          imageErrorWidget ?? const SizedBox.shrink(),
      placeholderErrorBuilder: (_, __, ___) =>
          placeholderErrorWidget ?? const SizedBox.shrink(),
    );
  }
}

class CommonCachedNetworkImage extends StatelessWidget {
  final String? image;
  final Widget? placeHolderWidget;
  final BoxFit? fit;
  final BoxFit? placeholderFit;
  final Widget? imageErrorWidget;
  final Widget? placeholderErrorWidget;
  final double? height;
  final double? width;

  const CommonCachedNetworkImage(
      {Key? key,
      required this.image,
      this.placeHolderWidget,
      this.fit,
      this.placeholderFit,
      this.imageErrorWidget,
      this.placeholderErrorWidget,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image ?? "",
      placeholder: (context, url) =>
          placeHolderWidget ?? const SizedBox.shrink(),
      errorWidget: (context, url, error) =>
          imageErrorWidget ?? const SizedBox.shrink(),
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      fit: fit ?? BoxFit.contain,
    );
  }
}

class CommonCachedNetworkImageFixed extends StatelessWidget {
  final String? image;
  final Widget? placeHolderWidget;
  final BoxFit? fit;
  final BoxFit? placeholderFit;
  final Widget? imageErrorWidget;
  final Widget? placeholderErrorWidget;
  final double height;
  final double width;

  const CommonCachedNetworkImageFixed(
      {Key? key,
      required this.image,
      this.placeHolderWidget,
      this.fit,
      this.placeholderFit,
      this.imageErrorWidget,
      this.placeholderErrorWidget,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image ?? "",
      placeholder: (context, url) =>
          placeHolderWidget ?? const SizedBox.shrink(),
      errorWidget: (context, url, error) =>
          imageErrorWidget ?? const SizedBox.shrink(),
      height: height,
      width: width,
      maxWidthDiskCache: context.cacheSize(width),
      maxHeightDiskCache: context.cacheSize(height),
      fit: fit ?? BoxFit.contain,
    );
  }
}
