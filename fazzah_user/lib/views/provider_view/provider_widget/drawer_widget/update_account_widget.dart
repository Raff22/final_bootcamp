// ignore_for_file: must_be_immutable
import 'package:fazzah_user/utils/imports.dart';

class UpdateAccountWidget extends StatelessWidget {
  const UpdateAccountWidget({super.key, required this.onPressed});
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialogAlerttt(
          context: context,
          titleText: 'تحديث بياناتك',
          contentText: 'هل أنت متأكد من تحديث بياناتك ؟',
          onPressed: onPressed,
        );
      },
      child: const TextWidget(
        text: 'تحديث حسابي',
        textSize: 18,
        textColor: dark1Green,
      ),
    );
  }
}
