import 'package:fazzah_user/constant/color.dart';
import 'package:flutter/material.dart';

class ChatField extends StatelessWidget {
  const ChatField({
    super.key,
    this.controller,
  });
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 364,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: black,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: grey)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: grey)),
          suffixIcon: const Icon(Icons.send),
          suffixIconColor: grey,
        ),
      ),
    );
  }
}
