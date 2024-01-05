import 'package:fazzah_user/utils/imports.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.pathImage});
  final String pathImage;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      pathImage,
      height: 137,
      width: 137.84,
    );
  }
}
