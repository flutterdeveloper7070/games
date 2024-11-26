import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_shimmer_effect.dart';

class AppImageAsset extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final bool isFile;
  final bool svgFromNetwork;
  final bool isMemory;
  final Widget? errorWidget;
  final Uint8List? memoryImage;

  const AppImageAsset({
    super.key,
    @required this.image,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.color,
    this.isFile = false,
    this.isMemory = false,
    this.svgFromNetwork = false,
    this.errorWidget,
    this.memoryImage,
  });

  @override
  Widget build(BuildContext context) {
    return image!.contains('http') && !image!.contains('svg')
        ? CachedNetworkImage(
            imageUrl: '$image',
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            placeholder: (context, url) => AppShimmerEffectView(
              height: height ?? double.maxFinite,
              width: width ?? double.maxFinite,
            ),
            errorWidget: (context, url, error) => errorWidget ?? const SizedBox(),
          )
        : isFile
            ? Image.file(
                File(image!),
                fit: fit,
                height: height,
                width: width,
                color: color,
              )
            : isMemory
                ? Image.memory(
                    memoryImage ?? base64Decode(image!),
                    fit: fit,
                    height: height,
                    width: width,
                    color: color,
                    gaplessPlayback: true,
                  )
                : image!.isEmpty || image!.split('.').last != 'svg'
                    ? Image.asset(
                        image!,
                        fit: fit,
                        height: height,
                        width: width,
                        color: color,
                        errorBuilder: (context, url, error) => errorWidget ?? const SizedBox(),
                      )
                    : svgFromNetwork
                        ? SvgPicture.network(
                            image!,
                            height: height,
                            width: width,
                            color: color,
                          )
                        : SvgPicture.asset(
                            image!,
                            height: height,
                            width: width,
                            color: color,
                          );
  }
}
