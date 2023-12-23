
import 'package:flutter_bloc/flutter_bloc.dart';

class VisiblePasswordCubit extends Cubit<bool> {
  VisiblePasswordCubit() : super(false);

  isVisiblePassword(bool isVisible) {
   isVisible = !isVisible;
  emit(isVisible);
}
}


