import 'package:flutter/material.dart';
import 'package:leaf_it/MainTheme.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CurvedAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HalfCircleClipper(),
      child: Container(
        height: preferredSize.height,
        decoration: BoxDecoration(
          color: MainTheme.LightGreen, //blue background
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: MainTheme.blueMain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(150); // Adjust height as needed
}

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height); // Start from bottom-left
    path.quadraticBezierTo(
      size.width / 2, // Control point (middle of the width)
      size.height - 80, // Adjust curve depth
      size.width, // End point
      size.height, // Bottom-right
    );
    path.lineTo(size.width, 0); // Top-right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
