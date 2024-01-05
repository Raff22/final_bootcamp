import 'package:fazzah_user/utils/imports.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget({super.key, required this.providerModel});

  final ProviderModel providerModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialogAlerttt(
            context: context,
            titleText: 'حذف الحساب',
            contentText: 'هل أنت متأكد من حذف الحساب ؟',
            onPressed: () {});
      },
      child: const TextWidget(
        text: 'حذف حسابي',
        textSize: 18,
        textColor: red,
      ),
    );
  }
}
