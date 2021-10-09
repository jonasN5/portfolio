import 'package:flutter/material.dart';

/// Clip an [imageAsset] borders to make an image more mobile like.
class MobileScreen extends StatelessWidget {
  final String imageAsset;
  final double? width;

  const MobileScreen({Key? key, required this.imageAsset, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(imageAsset, width: width));
  }
}
