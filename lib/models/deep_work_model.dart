class DeepWorkModel {
  int hoursOfDeepWork = 0;
  DateTime deepWorkdate;
  DeepWorkModel({required this.hoursOfDeepWork, required this.deepWorkdate});

  int get time {
    return hoursOfDeepWork;
  }

  @override
  String toString() {
    return 'DeepWorkModel{hoursOfDeepWork: $hoursOfDeepWork, deepWorkDate: $deepWorkdate}';
  }

  Map<String, dynamic> toMap() {
    return {
      'hoursOfDeepWork': hoursOfDeepWork,
      'date_time': deepWorkdate.toString(),
    };
  }
  
}
