import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  pushScreen({required Widget screen, Function(dynamic)? then}) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => screen))
        .then((value) {
      if (then != null) {
        then(value);
      }
    });
  }
  // pushScreen({required Widget screen, Function(dynamic)? then}) {
  //   Navigator.push(this, MaterialPageRoute(builder: (context) => screen))
  //       .then((value) {
  //     if (then != null) {
  //       then(value);
  //     }
  //   });
  // }

  popScreen({String? result}) {
    Navigator.pop(this, result);
  }

  removeUnitl({required Widget screen}) {
    Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (context) => screen),
        ModalRoute.withName("/screen"));
  }

  pushReplacement({required Widget screen}) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
