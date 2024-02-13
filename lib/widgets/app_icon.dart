import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  const AppIcon({super.key,  required this.icon,   this.backgroundColor= const Color.fromARGB(255, 255, 162, 208),
    this.iconColor=const  Color(0xFFfcf4e4),
    this.size=40,
    this.iconSize=16, });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size/2),
      color: backgroundColor
      ),
      child: Icon(icon, size: iconSize, color: iconColor,),
    );
  }
}
