// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:fazzah_user/utils/imports.dart';

class ProviderAccountView extends StatelessWidget {
  ProviderAccountView({super.key, this.providerModel});
  ProviderModel? providerModel;

  TextEditingController nameController = TextEditingController();

  TextEditingController nationalIDController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController nationalityController = TextEditingController();

  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = providerModel!.name!;
    nationalIDController.text = providerModel!.idNumber!;
    phoneNumberController.text = providerModel!.phoneNumber!;
    nationalityController.text = providerModel!.nationality!;
    jobController.text = providerModel!.job!;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar:
            createAppBar(context: context, title: 'حسابي', centerTitle: true),
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
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --------- Provider Name ----------
                        TextFieldProviderInfoWidget(
                          labelText: 'الأسم',
                          controllerText: nameController,
                          keyboardType: TextInputType.name,
                        ),
                        height10,

                        // -------- Provider Nationality ID ---------
                        TextFieldProviderInfoWidget(
                          labelText: 'رقم الإقامة',
                          controllerText: nationalIDController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            bool nationalIdValid =
                                FormatCheck().checkNationalId(value!);
                            if (!nationalIdValid) {
                              return 'يجب ان يكون الهوية الوطنية أو رقم الإقامة عشر أرقام';
                            }
                            return value;
                          },
                        ),
                        height10,

                        // ------ Provider Phone Number --------
                        TextFieldProviderInfoWidget(
                          labelText: 'رقم الهاتف',
                          controllerText: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            bool phoneValid = FormatCheck().checkPhone(value!);
                            if (!phoneValid) {
                              return '05xxxxxxxxx يجب ان يكون رقم الهاتف عشر أرقام ويبدا ب';
                            }
                            return value;
                          },
                        ),
                        height10,

                        // --------- Provider Nationality ----------
                        TextFieldProviderInfoWidget(
                          labelText: 'الجنسية',
                          controllerText: nationalityController,
                          keyboardType: TextInputType.text,
                        ),
                        height10,

                        // --------- Provider Job ----------
                        TextFieldProviderInfoWidget(
                          labelText: 'المهنة',
                          controllerText: jobController,
                          keyboardType: TextInputType.text,
                        ),
                        height20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UpdateAccountWidget(
                              onPressed: () {
                                context.read<ProviderBloc>().add(
                                    UpdateProviderAccountInfo(
                                        provider: providerModel!,
                                        name: nameController.text,
                                        nationalID: nationalIDController.text,
                                        nationality: nationalityController.text,
                                        phoneNumber: phoneNumberController.text,
                                        job: jobController.text));
                                context.popScreen();
                              },
                            ),
                            DeleteAccountWidget(
                              providerModel: providerModel!,
                            )
                          ],
                        ),
                      ],
                    );
                  }),
                ],
              ),
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
