import 'package:coffee_shop/bloc/base_bloc.dart';

class IndexPageBloc extends BaseBloc {
  int index = 0;

  void onChangedIndex(int selectedIndex) {
    index = selectedIndex;
    notifySafely();
  }
}
