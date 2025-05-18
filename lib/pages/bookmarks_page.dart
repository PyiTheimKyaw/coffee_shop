import 'package:coffee_shop/widgets/customized_text_view.dart';
import 'package:flutter/cupertino.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomizedTextView(textData: "Comming soon")
        ],
      ),
    );
  }
}
