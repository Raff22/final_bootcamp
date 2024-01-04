import 'package:fazzah_user/utils/imports.dart';

//---------------------------------معلومات----------------------------------------
class ProviderInfoWidget extends StatelessWidget {
  const ProviderInfoWidget({
    super.key,
    required this.provider,
  });

  final ProviderModel provider;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      provider.age != null
          ? ListTile(
              leading: const Icon(
                Icons.circle,
                color: green,
                size: 10,
              ),
              title: TextWidget(text: "العمر: ${provider.age!}", textSize: 20),
            )
          : const Text(""),
      provider.nationality != null
          ? ListTile(
              leading: const Icon(
                Icons.circle,
                color: green,
                size: 10,
              ),
              title: TextWidget(
                  text: "الجنسية: ${provider.nationality!}", textSize: 20),
            )
          : const Text(""),
      provider.certificate != null
          ? ListTile(
              leading: const Icon(
                Icons.circle,
                color: green,
                size: 10,
              ),
              title: TextWidget(text: provider.certificate!, textSize: 20),
            )
          : const Text(""),
    ]);
  }
}

//---------------------------------خدمات----------------------------------------
class ProviderServicesTabView extends StatelessWidget {
  const ProviderServicesTabView({
    super.key,
    required this.services,
  });

  final List<String> services;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: List.generate(
            services.length,
            (index) => ListTile(
                  leading: const Icon(
                    Icons.design_services_outlined,
                    color: green,
                  ),
                  title: TextWidget(text: services[index].trim(), textSize: 20),
                )));
  }
}

//---------------------------------آراء العملاء----------------------------------------
class MyRatingWidget extends StatelessWidget {
  const MyRatingWidget({
    super.key,
    required this.ratingInfo,
  });
  final Rating ratingInfo;

  @override
  Widget build(BuildContext context) {
    int starts = ratingInfo.rate!;

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
              text: ratingInfo.userName!,
              textFontWeight: FontWeight.w500,
              textSize: 20),
          Row(
            children: List.generate(5, (index) {
              if (starts > 0) {
                starts--;
                return const Icon(Icons.star_purple500_outlined,
                    color: coldGreen);
              }
              return const Icon(Icons.star_purple500_outlined,
                  color: lightGrey);
            }),
          ),
          TextWidget(text: ratingInfo.comment ?? "", textSize: 15),
        ],
      ),
      TextWidget(
          text:
              "${months[DateTime.parse(ratingInfo.createdAt!).month - 1]}, ${DateTime.parse(ratingInfo.createdAt!).year}")
    ]);
  }
}
