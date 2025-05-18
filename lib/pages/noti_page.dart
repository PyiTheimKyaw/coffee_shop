import 'package:flutter/material.dart';

import '../widgets/customized_text_view.dart';

class NotiPage extends StatelessWidget {
  const NotiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [CustomizedTextView(textData: "Comming soon")],
      ),
    );
  }
}
