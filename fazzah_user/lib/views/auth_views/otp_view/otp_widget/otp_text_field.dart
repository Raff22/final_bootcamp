import 'package:flutter/material.dart';

class OtpTextField extends StatelessWidget {
   OtpTextField({super.key , required this.pin});

  TextEditingController pin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: TextFormField(
        controller:pin,
        cursorColor: Colors.white,
        autofocus: true, //keyboard will shown
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: Theme.of(context).textTheme.titleLarge,
        onSaved: (pin1) {},
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: const Color.fromARGB(173, 198, 197, 197),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  width: 0, color: Color.fromARGB(173, 198, 197, 197))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  width: 0, color: Color.fromARGB(173, 198, 197, 197))),
        ),
      ),
    );
  }
}
