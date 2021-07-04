import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streaker/controllers/data_display_controller.dart';
import 'package:streaker/models/colortheme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //controller for setting
  DataDisplayController dataDisplayController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings "),
        elevation: 0,
        backgroundColor: ColorTheme.primaryColor,
      ),
      body: Container(
        color: ColorTheme.primaryColor,
        height: size.height,
        width: size.width,
        child: Obx(
          () => Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Set your goal (${dataDisplayController.goalInHours} hours)",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Slider(
                min: 2,
                max: (24 - dataDisplayController.sleepHours.value).toDouble(),
                value: dataDisplayController.goalInHours.toDouble(),
                onChanged: (double value) {
                  dataDisplayController.goalInHours.value = value.round();

                  //if the user has reduced there goal hours and if the input hours is more than it
                  if (dataDisplayController.hoursInput.value >
                      dataDisplayController.goalInHours.value) {
                    dataDisplayController.hoursInput.value = 0; //reset
                  }
                },
                divisions: 24 - dataDisplayController.sleepHours.value,
              ),
              SizedBox(height: 50),
              Obx(
                () => Text(
                  "Hours you sleep (${dataDisplayController.sleepHours} hours)",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Slider(
                min: 6,
                max: (24 - dataDisplayController.goalInHours.value).toDouble(),
                value: dataDisplayController.sleepHours.toDouble(),
                onChanged: (double value) {
                  dataDisplayController.sleepHours.value = value.round();
                },
                divisions: 24 - dataDisplayController.goalInHours.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
