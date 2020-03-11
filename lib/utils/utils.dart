import 'package:flutter_bloc_demo/configs.dart';

void log(dynamic data) {
  if (isCheat == true || buildFlavor != BuildFlavor.production) {
    final text = '$logTag${data.toString()}';

    if (showFullLog == true) {
      final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      pattern
          .allMatches(
            text,
          )
          .forEach(
            //ignore: avoid_print
            (match) => print(
              match.group(0),
            ),
          );
    } else {
      //ignore: avoid_print
      print(text);
    }
  }
}
