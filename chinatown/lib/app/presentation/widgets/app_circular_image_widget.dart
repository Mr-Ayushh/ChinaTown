import 'package:flutter/material.dart';

class AppCircularImage extends StatelessWidget {
  const AppCircularImage({super.key, this.url, this.radius});
  final String? url;
  final double? radius;

  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: radius ?? 18.0, // Image radius
        backgroundImage: NetworkImage(
          url!,
        ),
      );
}
