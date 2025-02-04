import 'package:child_community/service/themes/color_scheme.dart';
import 'package:child_community/util/images.dart';
import 'package:flutter/material.dart';


class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double weight;
  final bool isColor;
  const ProfileAvatar({super.key, required this.imageUrl, this.height = 32, this.weight=32, this.isColor = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: weight,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isColor ? Theme.of(context).colorScheme.crossColor.withOpacity(0.1) : null
      ),
      child: ClipOval(child: Image.asset(AllImages.profilePlaceHolder,fit: BoxFit.scaleDown)
      ),
    );
  }
}