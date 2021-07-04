import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:streaker/controllers/db_controller.dart';
import 'package:streaker/models/colortheme.dart';
import 'package:streaker/models/deep_work_model.dart';
import 'package:streaker/widgets/custom_button.dart';
import 'package:streaker/widgets/custom_heat_box.dart';

class HomePage extends StatefulWidget {
  final Future<Database> db;
  const HomePage({Key? key, required this.db}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //format of DateTime - YYYY-MM-DD
  List<DeepWorkModel> deepWorksData = [
    DeepWorkModel(
        hoursOfDeepWork: 0, deepWorkdate: DateTime.parse('2021-06-19')),
    DeepWorkModel(
        hoursOfDeepWork: 8, deepWorkdate: DateTime.parse('2021-06-20')),
    DeepWorkModel(
        hoursOfDeepWork: 5, deepWorkdate: DateTime.parse('2021-06-21')),
    DeepWorkModel(
        hoursOfDeepWork: 6, deepWorkdate: DateTime.parse('2021-06-22')),
    DeepWorkModel(
        hoursOfDeepWork: 5, deepWorkdate: DateTime.parse('2021-06-23')),
    DeepWorkModel(
        hoursOfDeepWork: 7, deepWorkdate: DateTime.parse('2021-03-07')),
    DeepWorkModel(
        hoursOfDeepWork: 6, deepWorkdate: DateTime.parse('2021-03-07')),
    DeepWorkModel(
        hoursOfDeepWork: 4, deepWorkdate: DateTime.parse('2021-03-07')),
    DeepWorkModel(
        hoursOfDeepWork: 8, deepWorkdate: DateTime.parse('2021-03-07')),
    DeepWorkModel(
        hoursOfDeepWork: 5, deepWorkdate: DateTime.parse('2021-03-07')),
    DeepWorkModel(
        hoursOfDeepWork: 9, deepWorkdate: DateTime.parse('2021-03-07')),
    DeepWorkModel(
        hoursOfDeepWork: 9, deepWorkdate: DateTime.parse('2021-03-07')),
    DeepWorkModel(
        hoursOfDeepWork: 3, deepWorkdate: DateTime.parse('2021-03-07')),
    DeepWorkModel(
        hoursOfDeepWork: 1, deepWorkdate: DateTime.parse('2021-03-07')),
  ];

  int random = 1;

  DBController dbController = DBController();
  int hoursStudied = 0;

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
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red)),
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
                  }),

              //slider time widget
              Slider(
                min: 0,
                max: 12,
                value: hoursStudied.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    hoursStudied = value.round();
                  });
                },
                divisions: 12,
              ),

              //display hours studied
              Text(
                "Hours studied $hoursStudied",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Container(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    insertingFunction();
                    // dbController.deleteDeepWorkData(widget.db);
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(4),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    dbController.showAllData(widget.db);
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(4),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: Text("Show all data",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void insertingFunction() {
    random++;
    setState(() {
      deepWorksData.add(DeepWorkModel(
          hoursOfDeepWork: random % 12, deepWorkdate: DateTime.now()));
    });

    dbController.insertDeepWorkData(
        widget.db,
        DeepWorkModel(
            hoursOfDeepWork: hoursStudied, deepWorkdate: DateTime.now()));
    deepWorksData.forEach((element) {
      print(element.hoursOfDeepWork);
    });
  }
}
