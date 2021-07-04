import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  double height = 50;
  double width = 150;
  double cornerRadius = 10;
  final Function function;
  String content = "A Button";
  Color buttonColor = Colors.green;
  double contentSize = 14;
  Color textColor = Colors.white;

  CustomButton(
      {required this.height,
      required this.width,
      required this.cornerRadius,
      required this.function,
      required this.content,
      required this.buttonColor,
      required this.contentSize,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: () => function,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(4),
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
          ),
        ),
        child: Text(content,
            style: TextStyle(fontSize: contentSize, color: textColor)),
      ),
    );
  }
}
