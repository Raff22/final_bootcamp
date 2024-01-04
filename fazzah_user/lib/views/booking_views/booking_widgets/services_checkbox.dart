import 'package:fazzah_user/utils/imports.dart';

class ServiceCheckBox extends StatelessWidget {
  const ServiceCheckBox(
      {super.key, required this.serviceName, required this.state});
  final String serviceName;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            shape: const CircleBorder(side: BorderSide()),
            value: state,
            onChanged: (value) {},
            fillColor: null,
            activeColor: black),
        TextWidget(
          text: serviceName,
          textSize: 22,
        ),
      ],
    );
  }
}
