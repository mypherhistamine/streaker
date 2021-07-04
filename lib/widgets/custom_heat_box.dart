import 'package:flutter/material.dart';
import 'package:streaker/models/deep_work_model.dart';

class CustomHeatBox extends StatefulWidget {
  final DeepWorkModel deepWorkModel;
  const CustomHeatBox({Key? key, required this.deepWorkModel})
      : super(key: key);

  @override
  _CustomHeatBoxState createState() => _CustomHeatBoxState();
}

class _CustomHeatBoxState extends State<CustomHeatBox> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: SizedBox(
        height: 20,
        width: 20,
        child: GestureDetector(
          onTap: () {
            print("tapped");
            setState(() {
              isTapped = !isTapped;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: isTapped ? Colors.yellowAccent : Colors.transparent),
              borderRadius: BorderRadius.circular(5),
              color: widget.deepWorkModel.time == 0
                  ? Color.fromRGBO(196, 196, 196, 1).withAlpha(40)
                  : Color(0x03c04a).withAlpha(
                      ((widget.deepWorkModel.time / 12) * 250).toInt()),
            ),
            // color: Colors.red,
            // child: Text("R"),
          ),
        ),
      ),
    );
  }
}
