// ignore_for_file: must_be_immutable

import 'package:fazzah_user/bloc/provider_bloc/provider_bloc.dart';
import 'package:fazzah_user/bloc/provider_bloc/provider_event.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/helpers/show_dioalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateAccountWidget extends StatelessWidget {
  const UpdateAccountWidget(
      {super.key,
      required this.name,
      required this.nationalID,
      required this.nationality,
      required this.phoneNumber,
      required this.job,
      required this.providerModel});
  final ProviderModel providerModel;
  final String? name;
  final String? nationalID;
  final String? phoneNumber;
  final String? nationality;
  final String? job;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialogAlerttt(
          context: context,
          titleText: 'تحديث بياناتك',
          contentText: 'هل أنت متأكد من تحديث بياناتك ؟',
          onPressed: () {
            context.popScreen();
            context.read<ProviderBloc>().add(UpdateProviderAccountInfo(
                providerID: providerModel.id!,
                name: name ?? providerModel.name,
                nationalID: nationalID ?? providerModel.idNumber,
                nationality: nationality ?? providerModel.nationality,
                phoneNumber: phoneNumber ?? providerModel.phoneNumber,
                job: job ?? providerModel.job));
          },
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
