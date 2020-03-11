import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/ui/dialogs/notify_dialog.dart';
import 'package:flutter_bloc_demo/ui/widgets/simple_button.dart';

Widget errorInternet(
    {String titlePopup = 'Oh No!',
    TextStyle styleTextTitle =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    TextStyle styleTextContent =
        const TextStyle(fontSize: 13, color: Colors.black45),
    TextStyle styleTextButton = const TextStyle(color: Colors.white),
    String content =
        'No internet connection found.\n Check your connection and try again',
    String titleButton = 'Try again',
    Function() onTap,
    Icon iconPopup = const Icon(Icons.wifi, color: Colors.red, size: 150),
    double width = 250,
    double height = 280}) {
  return NotifyDialog(
    iconPopup: iconPopup,
    titlePopup: Text(
      titlePopup,
      style: styleTextTitle,
    ),
    content: Text(
      content,
      style: styleTextContent,
      textAlign: TextAlign.center,
    ),
    buttonActions: [
      SimpleButton(
        width: 120,
        height: 45,
        borderRadius: 8,
        textStyle: styleTextButton,
        text: titleButton,
        bgColors: [Colors.redAccent, Colors.redAccent],
        onPressed: onTap,
      )
    ],
    width: width,
    height: height,
  );
}

Widget errorNotiedErrorPopup(
    {String titlePopup = 'Oh No!',
    TextStyle styleTextTitle =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    TextStyle styleTextContent =
        const TextStyle(fontSize: 13, color: Colors.black45),
    TextStyle styleTextButton = const TextStyle(color: Colors.white),
    String content = 'Something went wrong!',
    String titleButton = 'Close',
    Function() onTap,
    Icon iconPopup = const Icon(Icons.error, color: Colors.red, size: 150),
    double width = 250,
    double height = 280}) {
  return NotifyDialog(
    iconPopup: iconPopup,
    titlePopup: Text(
      titlePopup,
      style: styleTextTitle,
    ),
    content: Text(
      content,
      style: styleTextContent,
      textAlign: TextAlign.center,
    ),
    buttonActions: [
      SimpleButton(
        width: 120,
        height: 45,
        borderRadius: 8,
        textStyle: styleTextButton,
        text: titleButton,
        bgColors: [Colors.redAccent, Colors.redAccent],
        onPressed: onTap,
      )
    ],
    width: width,
    height: height,
  );
}
