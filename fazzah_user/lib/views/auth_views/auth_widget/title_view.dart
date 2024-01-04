import 'package:fazzah_user/utils/imports.dart';

class TitleView extends StatelessWidget {
  const TitleView({super.key, required this.title, required this.supTitle});
  final String title;
  final String supTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: title,
            textSize: 34,
          ),
          height12,
          TextWidget(
            text: supTitle,
            textSize: 18,
          )
        ],
      ),
    );
  }
}
