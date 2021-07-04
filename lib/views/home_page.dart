import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:streaker/controllers/data_display_controller.dart';
import 'package:streaker/controllers/db_controller.dart';
import 'package:streaker/models/colortheme.dart';
import 'package:streaker/models/deep_work_model.dart';
import 'package:streaker/views/settings_page.dart';
import 'package:streaker/widgets/custom_heat_box.dart';

class HomePage extends StatefulWidget {
  final Future<Database> db;
  const HomePage({Key? key, required this.db}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //format of DateTime - YYYY-MM-DD

  //controller for SQLite database operations
  DBController dbController = DBController();
  //variable used by slider widget
  //controller for Data Display Operations
  DataDisplayController dataDisplayController =
      Get.put(DataDisplayController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: ColorTheme.primaryColor,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              FutureBuilder<List<DeepWorkModel>>(
                future: dbController.showAllData(widget.db),
                builder: (BuildContext context,
                    AsyncSnapshot<List<DeepWorkModel>> snapshot) {
                  return Column(
                    children: [
                      Text(
                        "Data for ${snapshot.data!.length} days ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      //heatmap UI
                      Container(
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.red)),
                        height: size.height * 0.5,
                        width: size.width * 0.95,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7),
                          itemBuilder: (BuildContext context, int index) {
                            // if (index % 2 == 0) {
                            //   return Text("Lol");
                            // }
                            if (snapshot.hasData) {
                              print(snapshot.data![index]);
                              return CustomHeatBox(
                                  deepWorkModel: snapshot.data![index]);
                            }
                            return Container();
                          },
                          itemCount: snapshot.data!.length,
                        ),
                      ),
                    ],
                  );
                },
                //displays initial data while db is loading
                initialData: [
                  DeepWorkModel(
                      hoursOfDeepWork: 0, deepWorkdate: DateTime.now())
                ],
              ),
              //slider time widget
              Obx(
                () => Slider(
                  min: 0,
                  max: dataDisplayController.goalInHours.value.toDouble(),
                  value: dataDisplayController.hoursInput.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      if (value > dataDisplayController.goalInHours.value) {
                        dataDisplayController.hoursInput.value = 0;
                        //subtract the excess in order to avoid errors
                      }
                      dataDisplayController.hoursInput.value = value.round();
                    });
                  },
                  divisions: 12,
                ),
              ),

              //display hours studied
              Obx(
                () => Text(
                  "Hours studied ${dataDisplayController.hoursInput}",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),

              //display info of tapped deep work cell
              Obx(
                () => Column(
                  children: [
                    Text(
                      "Hours: ${dataDisplayController.hoursOfDeepWork}",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      dataDisplayController.hoursOfDeepWork.value != null
                          ? "Date: ${dataDisplayController.date}"
                          : '',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
              //operation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () {
                        //this function inserts the data in the database
                        insertingFunction();
                        // dbController.deleteDeepWorkData(widget.db);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(4),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: Text("Log",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        dbController.showAllData(widget.db);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(4),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: Text("Data",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          dbController.deleteAllData(widget.db);
                        });
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(4),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: Text("Delete",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                ],
              ),
              //settings button
              SizedBox(height: 20),
              Center(
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (route) => SettingsPage()));
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(4),
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: Text("Settings",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void insertingFunction() {
    setState(() {
      dbController.insertDeepWorkData(
          widget.db,
          DeepWorkModel(
              hoursOfDeepWork: dataDisplayController.hoursInput.value,
              deepWorkdate: DateTime.now()));
    });
  }
}
