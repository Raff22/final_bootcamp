import 'package:fazzah_user/utils/imports.dart';

class ChangeLocationView extends StatelessWidget {
  const ChangeLocationView({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: BottomSheet(
            showDragHandle: true,
            backgroundColor: white,
            onClosing: () {},
            builder: (context) {
              return SizedBox(
                height: context.getHeight(divide: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const TextWidget(
                        text: "Riyadh",
                        textSize: 22,
                        textFontWeight: FontWeight.w500,
                      ),
                      const TextWidget(
                          text:
                              "RAYA6774, 4422 Al Qadisiyah, 7535, An Narjis, Riyadh 13326,حي الياسمين, Saudi Arabia",
                          textSize: 14),
                      height20,
                      Center(
                        child: ContainerWidget(
                            contanierBorderRadius: 10,
                            containerWidth: 366,
                            containerHeight: 48,
                            containerColor: green,
                            onPressed: () {},
                            child: const Center(
                                child: TextWidget(
                              text: "تغيير الموقع",
                              textSize: 25,
                              textColor: lightGrey,
                            ))),
                      ),
                    ],
                  ),
                ),
              );
            }),
        appBar: createAppBar(
            title: "تغيير الموقع",
            context: context,
            leading: IconButton(
                onPressed: () {
                  context.popScreen();
                },
                icon:
                    const Icon(Icons.arrow_back_ios, size: 20, color: black))),
        body: Image.asset('assets/images/map_placeholder.png'));
  }
}
 //Icons.chrome_reader_mode_outlined)
//Icons.contact_phone_rounded)
