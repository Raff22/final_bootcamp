import 'package:fazzah_user/utils/imports.dart';

class RowTowTextWidget extends StatelessWidget {
  const RowTowTextWidget(
      {super.key,
      required this.askText,
      required this.textButtom,
      required this.navigatorTo,
      required this.mainAxisAlignment});

  final String askText;
  final String textButtom;
  final Function() navigatorTo;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        // ----------- first Text --------------

        TextWidget(text: askText),
        width4,
        // ----------- second Inkwell Text --------------

        InkWell(
          onTap: navigatorTo,
          child: TextWidget(
            text: textButtom,
            textDecoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
