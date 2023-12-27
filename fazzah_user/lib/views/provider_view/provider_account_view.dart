import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/provider_view/provider_widget/drawer_provider_widget.dart';
import 'package:flutter/material.dart';

class ProviderAccountView extends StatelessWidget {
  const ProviderAccountView({super.key, this.providerModel});
  final ProviderModel? providerModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          createAppBar(context: context, title: 'حسابي', centerTitle: true),
      drawer: DrawerProviderWidget(providerModel: providerModel),
      body:const SafeArea(
        child: Center(
          child: Text('حسابي'),
        ),
      ),
    );
  }
}

//  Column(
//           children: [
//             //---------------- upload provider image -------------------

//             BlocBuilder<ProviderBloc, ProviderState>(
//               builder: (context, state) {
//                 if (state is LoadingImageProviderState) {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       color: green,
//                     ),
//                   );
//                 }
//                 if (state is SuccessUploadedImageState) {
//                   return ClipOval(
//                     child: ContainerWidget(
//                       contanierBorderRadius: 0,
//                       containerHeight: context.getWidth(divide: 3),
//                       containerWidth: context.getWidth(divide: 3),
//                       child: (profileImage == null || profileImage!.isEmpty)
//                           ? Image.asset(
//                               'assets/images/image_provider.png',
//                               fit: BoxFit.fill,
//                             )
//                           : CachedNetworkImage(
//                               imageUrl: profileImage!,
//                               height: 100,
//                               width: 100,
//                               fit: BoxFit.fill,
//                             ),
//                     ),
//                   );
//                 }
//                 return ClipOval(
//                   child: ContainerWidget(
//                     contanierBorderRadius: 0,
//                     containerHeight: context.getWidth(divide: 3),
//                     containerWidth: context.getWidth(divide: 3),
//                     child: (profileImage == null || profileImage!.isEmpty)
//                         ? Image.asset(
//                             'assets/images/image_provider.png',
//                             fit: BoxFit.fill,
//                           )
//                         : CachedNetworkImage(
//                             imageUrl: providerModel!.providerImage!,
//                             height: 100,
//                             width: 100,
//                             fit: BoxFit.fill,
//                           ),
//                   ),
//                 );
//               },
//             ),
//             height10,

//             InkWell(
//               onTap: () async {
//                 File image = await pickImageFromeGallery();
//                 print(image.path);
//                 context.read<ProviderBloc>().add(UploadProviderImageEvent(
//                     imageFile: image, providerModel: providerModel));
//               },
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextWidget(
//                     text: 'ارفاق الصورة الشخصية',
//                     textColor: grey,
//                     textSize: 15,
//                   ),
//                   width6,
//                   Icon(
//                     Icons.add_a_photo_rounded,
//                     color: grey,
//                   ),
//                 ],
//               ),
//             ),
//             height20,
//             Text(providerModel!.email!),
//             Text(providerModel!.id!),
//             Text(providerModel!.name!),
//             Text(providerModel!.phoneNumber!)
//           ],
//         )),


  // Future pickImageFromeGallery() async {
  //   final imagePick =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (imagePick != null) {
  //     File image = File(imagePick.path);
  //     return image;
  //   } else {
  //     return null;
  //   }
  // }