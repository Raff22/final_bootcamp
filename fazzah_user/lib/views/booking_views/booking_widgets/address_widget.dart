import 'package:fazzah_user/utils/imports.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key, required this.addi, required this.state});
  final Address addi;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
          shape: const CircleBorder(side: BorderSide()),
          value: state,
          onChanged: (value) {},
          fillColor: null,
          activeColor: black),
      title: TextWidget(
        text: addi.addressTitle!,
        textSize: 22,
      ),
      subtitle: TextWidget(
        text: addi.address!,
        textSize: 16,
      ),
    );
  }
}
