import 'package:fazzah_user/utils/imports.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(height: context.getHeight(divide: 4)),
      Image.asset(
        'assets/images/Electrician-pana 1.png',
        width: context.getWidth(divide: 2),
      ),
      TextWidget(
        text: message,
        textColor: green,
        textSize: 25,
      )
    ]);
  }
}
