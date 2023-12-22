import 'package:flutter_bloc/flutter_bloc.dart';

class IsProviderCubit extends Cubit<bool> {
  IsProviderCubit() : super(false);

  isProvider(bool isProvider) {
    isProvider = !isProvider;
    emit(isProvider);
  }
}
