import 'package:fazzah_user/constant/color.dart';
import 'package:flutter/material.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({
    super.key,
    required this.icon,
    required this.onpressed,
  });
  final IconData icon;
  final Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: lightGreen,
        child: IconButton(
            color: green, onPressed: onpressed, icon: Icon(icon, size: 20)),
      ),
    );
  }
}
