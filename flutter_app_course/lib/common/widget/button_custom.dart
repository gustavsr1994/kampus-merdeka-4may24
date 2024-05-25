import 'package:flutter/material.dart';
import 'package:flutter_app_course/common/style.dart';

class ButtonCustom extends StatelessWidget {
  Function() onPressed;
  String nameButton;
  Color colorButton;
  ButtonCustom(this.onPressed, this.nameButton, this.colorButton, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorButton,
          elevation: 3,
        ),
        child: Text(
          nameButton,
          style: mediumText(salmonColor, fontWeight: true),
        ));
  }
}
