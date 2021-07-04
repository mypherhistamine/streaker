import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:streaker/views/home_page.dart';

Future<Database> database = null as Future<Database>;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print(await getDatabasesPath());
  database = openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE deepwork(id INTEGER PRIMARY KEY,hoursOfDeepWork INTEGER, date_time TEXT)',
      );
    },
    version: 1,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        db: database,
      ),
    );
  }
}
