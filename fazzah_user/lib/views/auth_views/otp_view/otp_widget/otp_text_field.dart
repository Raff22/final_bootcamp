// ignore_for_file: must_be_immutable
import 'package:fazzah_user/utils/imports.dart';

class OtpTextField extends StatelessWidget {
  OtpTextField({super.key, required this.pin});

  TextEditingController pin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 50,
      child: TextFormField(
        controller: pin,
        cursorColor: dark1Green,
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
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  width: 1, color: Color.fromARGB(173, 198, 197, 197))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  width: 1, color: Color.fromARGB(173, 198, 197, 197))),
        ),
      ),
    );
  }
}
