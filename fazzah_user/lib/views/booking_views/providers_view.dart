import 'package:fazzah_user/utils/imports.dart';

class ProvidersScreen extends StatelessWidget {
  const ProvidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Scaffold(
        appBar: createAppBar(
            title: "الفنيين",
            context: context,
            leading: IconButton(
                onPressed: () {
                  context.popScreen();
                },
                icon:
                    const Icon(Icons.arrow_back_ios, size: 20, color: black))),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              height20,
              SearchBarWidget(
                  hint: "ابحث عن فني",
                  onSubmmited: (String) {
                    context
                        .read<BookingBloc>()
                        .add(RequestProvidersByNameEvent(name: search.text));
                  },
                  controller: search),
              height20,
              BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  if (state is BookingLoadingState) {
                    return const Center(
                        child: Center(
                            child: CircularProgressIndicator(color: green)));
                  } else if (state is ShowAllProvidersState) {
                    if (state.providers.isEmpty) {
                      return const NotFoundWidget(
                          message: "نعتذر، لا يوجد ما تبحث عنه حاليًا");
                    }
                    return SizedBox(
                      width: context.getWidth(),
                      height: context.getHeight(),
                      child: ListView.separated(
                          itemCount: state.providers.length,
                          itemBuilder: (context, index) => WorkerCard(
                              isFav: state.favs[index],
                              providerInfo: state.providers[index]),
                          separatorBuilder: (BuildContext context, int index) {
                            return height20;
                          }),
                    );
                  } else if (state is BookingErrorState) {
                    return Center(child: Text(state.error));
                  }
                  return Container();
                },
              )
            ],
          ),
        ));
  }
}
