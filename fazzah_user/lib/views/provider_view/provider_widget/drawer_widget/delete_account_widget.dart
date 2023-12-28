import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/helpers/show_dioalog.dart';
import 'package:flutter/material.dart';

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
            onPressed: () {
              
            });
      },
      child: const TextWidget(
        text: 'حذف حسابي',
        textSize: 18,
        textColor: red,
      ),
    );
  }
}
