import 'package:flutter/foundation.dart';

class BaseBloc extends ChangeNotifier {
  bool isDisposed = false;

  // Callback to notify only when the screen is currently visible
  void notifySafely() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  //Callback to dispose from memory when the corresponding page is no longer on the screen
  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
