import 'package:fazzah_user/constant/color.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.hint,
    this.controller,
  });
  final String hint;
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
            hintText: hint,
            hintStyle: const TextStyle(
                color: grey,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                decorationThickness: 6),
            suffixIcon: const Icon(Icons.mic),
            suffixIconColor: grey,
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: grey),
      ),
    );
  }
}
