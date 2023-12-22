import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:flutter/material.dart';

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
          context: context,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios, size: 20, color: black))),
    );
  }
}
