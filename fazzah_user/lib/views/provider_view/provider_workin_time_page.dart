import 'package:fazzah_user/utils/imports.dart';

class ProviderWorkTimePage extends StatelessWidget {
  const ProviderWorkTimePage({super.key, required this.providerModel});

  final ProviderModel? providerModel;

  @override
  Widget build(BuildContext context) {
    List<bool> selectedWorkinghrs = [];
    return Scaffold(
        appBar: createAppBar(
            context: context, title: 'اوقات العمل', centerTitle: true),
        drawer: DrawerProviderWidget(providerModel: providerModel),
        body: BlocBuilder<ProviderBloc, ProviderState>(
          builder: (context, state) {
            if (state is LoadingUpdateProviderAccountState) {
              return const Center(
                  child: CircularProgressIndicator(color: coldGreen));
            }
            if (state is ShowProviderTheirWorkingHours) {
              selectedWorkinghrs = state.wHours.getHoursAvailabilityList();
            }
            if (state is UpdateHourSwitchState) {
              selectedWorkinghrs = state.wHours;
            }
            return Column(
              children: [
                height20,
                Column(
                  children: List.generate(
                    hours.length,
                    (index) {
                      return SwitchListTile(
                          inactiveTrackColor: grey,
                          activeColor: coldGreen,
                          title: TextWidget(
                            text: hours[index],
                            textSize: 20,
                            textColor: green,
                          ),
                          value: selectedWorkinghrs[index],
                          onChanged: (value) {
                            selectedWorkinghrs[index] =
                                !selectedWorkinghrs[index];
                            context.read<ProviderBloc>().add(
                                SelectHourSwitchEvent(
                                    wHours: selectedWorkinghrs));
                          });
                    },
                  ),
                ),
                height30,
                height30,
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BlocListener<ProviderBloc, ProviderState>(
                    listener: (context, state) {
                      if (state is UpdatedProviderWorkingHoursSuccessState) {
                        print("UpdatedProviderWorkingHoursSuccessState");
                        showMessageDialog(
                            context: context, message: 'حدثت أوقات عملك بنجاح');
                      }
                    },
                    child: ContainerWidget(
                        contanierBorderRadius: 10,
                        containerWidth: context.getWidth(),
                        containerHeight: 48,
                        containerColor: green,
                        onPressed: () {
                          final WorkingHours hrs = WorkingHours(
                              id: providerModel!.id!,
                              hour10am: selectedWorkinghrs[0],
                              hour11am: selectedWorkinghrs[1],
                              hour12pm: selectedWorkinghrs[2],
                              hour1pm: selectedWorkinghrs[3],
                              hour2pm: selectedWorkinghrs[4],
                              hour3pm: selectedWorkinghrs[5],
                              hour4pm: selectedWorkinghrs[6],
                              hour5pm: selectedWorkinghrs[7],
                              hour6pm: selectedWorkinghrs[8],
                              hour7pm: selectedWorkinghrs[9]);
                          context
                              .read<ProviderBloc>()
                              .add(UpdateProviderWorkingHours(wHours: hrs));
                        },
                        child: const Center(
                            child: TextWidget(
                          text: "تحديث اوقات العمل",
                          textSize: 25,
                          textColor: lightGrey,
                        ))),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
