// ignore_for_file: use_build_context_synchronously, must_be_immutable
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazzah_user/bloc/provider_bloc/provider_bloc.dart';
import 'package:fazzah_user/bloc/provider_bloc/provider_event.dart';
import 'package:fazzah_user/bloc/provider_bloc/provider_state.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/provider_view/provider_widget/drawer_provider_widget.dart';
import 'package:fazzah_user/views/provider_view/provider_widget/drawer_widget/text_field_provider_info_widget.dart';
import 'package:fazzah_user/views/provider_view/provider_widget/drawer_widget/delete_account_widget.dart';
import 'package:fazzah_user/views/provider_view/provider_widget/drawer_widget/update_account_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProviderAccountView extends StatelessWidget {
  ProviderAccountView({super.key, this.providerModel});
  final ProviderModel? providerModel;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nationalIDController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = providerModel!.name!;
    return Scaffold(
      appBar: createAppBar(context: context, title: 'حسابي', centerTitle: true),
      drawer: DrawerProviderWidget(providerModel: providerModel),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                //---------------- Upload Provider Image -------------------
                BlocBuilder<ProviderBloc, ProviderState>(
                  builder: (context, state) {
                    if (state is LoadingImageProviderState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: green,
                        ),
                      );
                    }
                    if (state is SuccessUploadedImageState) {
                      providerModel!.providerImage = state.providerImagePath;
                    }
                    return ClipOval(
                      child: ContainerWidget(
                        contanierBorderRadius: 0,
                        containerHeight: context.getWidth(divide: 3),
                        containerWidth: context.getWidth(divide: 3),
                        child: providerModel!.providerImage == null ||
                                providerModel!.providerImage!.isEmpty
                            ? Image.asset(
                                'assets/images/image_provider.png',
                                fit: BoxFit.fill,
                              )
                            : CachedNetworkImage(
                                imageUrl: providerModel!.providerImage!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                      ),
                    );
                  },
                ),
                height10,

                //------------------ Click To Upload Image -----------------------
                InkWell(
                  onTap: () async {
                    File image = await pickImageFromeGallery();
                    print(image.path);
                    context.read<ProviderBloc>().add(UploadProviderImageEvent(
                        imageFile: image, providerModel: providerModel));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_rounded,
                        color: grey,
                      ),
                      width6,
                      TextWidget(
                        text: 'ارفاق أو تعديل الصورة الشخصية',
                        textColor: grey,
                        textSize: 15,
                      ),
                    ],
                  ),
                ),

                //--------------------- Account Info -----------------------------
                BlocBuilder<ProviderBloc, ProviderState>(
                  builder: (context, state) {
                    if (state is LoadingUpdateProviderAccountState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: green,
                        ),
                      );
                    } else if (state is SuccessUpdateProviderAccountState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --------- Provider Name ----------
                          TextFieldProviderInfoWidget(
                            labelText: 'الأسم',
                            controllerText: nameController,
                            onChanged: (value) {
                              value = state.providerModel!.name!;
                            },
                          ),
                          height10,

                          // -------- Provider Nationality ID ---------
                          TextFieldProviderInfoWidget(
                            labelText: 'رقم الإقامة',
                            controllerText: nationalIDController,
                            onChanged: (value) {
                              value = state.providerModel!.idNumber!;
                            },
                          ),
                          height10,

                          // ------ Provider Phone Number --------
                          TextFieldProviderInfoWidget(
                            labelText: 'رقم الهاتف',
                            controllerText: phoneNumberController,
                            onChanged: (value) {
                              value = state.providerModel!.phoneNumber!;
                            },
                          ),
                          height10,

                          // --------- Provider Nationality ----------
                          TextFieldProviderInfoWidget(
                            labelText: 'الجنسية',
                            controllerText: nationalityController,
                            onChanged: (value) {
                              value = state.providerModel!.nationality!;
                            },
                          ),
                          height10,

                          // --------- Provider Job ----------
                          TextFieldProviderInfoWidget(
                            labelText: 'المهنة',
                            controllerText: jobController,
                            onChanged: (value) {
                              value = state.providerModel!.job!;
                            },
                          ),
                          height20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UpdateAccountWidget(
                                providerModel: providerModel!,
                                name: nameController.text,
                                phoneNumber: phoneNumberController.text,
                                nationalID: nationalIDController.text,
                                nationality: nationalityController.text,
                                job: jobController.text,
                              ),
                              DeleteAccountWidget(
                                providerModel: providerModel!,
                              )
                            ],
                          ),
                        ],
                      );
                    } else if (state is ErrorUpdateProviderAccountState) {
                      return Text(state.errorMessage);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --------- Provider Name ----------
                        TextFieldProviderInfoWidget(
                          labelText: 'الأسم',
                          controllerText: nameController,
                          onChanged: (value) {
                            value = providerModel!.name!;
                          },
                        ),
                        height10,

                        // -------- Provider Nationality ID ---------
                        TextFieldProviderInfoWidget(
                          labelText: 'رقم الإقامة',
                          controllerText: nationalIDController,
                          onChanged: (value) {
                            value = providerModel!.idNumber!;
                          },
                        ),
                        height10,

                        // ------ Provider Phone Number --------
                        TextFieldProviderInfoWidget(
                          labelText: 'رقم الهاتف',
                          controllerText: phoneNumberController,
                          onChanged: (value) {
                            value = providerModel!.phoneNumber!;
                          },
                        ),
                        height10,

                        // --------- Provider Nationality ----------
                        TextFieldProviderInfoWidget(
                          labelText: 'الجنسية',
                          controllerText: nationalityController,
                          onChanged: (value) {
                            value = providerModel!.nationality!;
                          },
                        ),
                        height10,

                        // --------- Provider Job ----------
                        TextFieldProviderInfoWidget(
                          labelText: 'المهنة',
                          controllerText: jobController,
                          onChanged: (value) {
                            value = providerModel!.job!;
                          },
                        ),
                        height20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UpdateAccountWidget(
                              providerModel: providerModel!,
                              name: nameController.text,
                              phoneNumber: phoneNumberController.text,
                              nationalID: nationalIDController.text,
                              nationality: nationalityController.text,
                              job: jobController.text,
                            ),
                            DeleteAccountWidget(
                              providerModel: providerModel!,
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImageFromeGallery() async {
    final imagePick =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePick != null) {
      File image = File(imagePick.path);
      return image;
    } else {
      return null;
    }
  }
}
