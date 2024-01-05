import 'package:fazzah_user/utils/imports.dart';

class HourWidget extends StatelessWidget {
  const HourWidget({
    super.key,
    required this.isAvailable,
    required this.hour,
    required this.isSelected,
  });
  final bool isAvailable;
  final String hour;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
            padding: const EdgeInsets.all(7),
            color: getTheRightColor(),
            child: TextWidget(text: hour, textSize: 20)),
      ),
    );
  }

  Color getTheRightColor() {
    if (isAvailable) {
      if (isSelected) {
        return coldGreen;
      }
      return lightGreen;
    }
    return grey;
  }
}
