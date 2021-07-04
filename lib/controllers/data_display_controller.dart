import 'package:get/get.dart';
import 'package:streaker/models/deep_work_model.dart';

class DataDisplayController extends GetxController {
  Rx<int> hoursOfDeepWork = 0.obs;
  Rx<int> hoursInput = 0.obs;
  Rx<String> date = '2021-07-04 18:23:24.706671'.obs;
  Rx<int> goalInHours = 12.obs;
  Rx<int> sleepHours = 8.obs;

  void changeDisplayData(DeepWorkModel model) {
    hoursOfDeepWork.value = model.hoursOfDeepWork;
    date.value = model.deepWorkdate.toString();
    print('''
    Hours : ${hoursOfDeepWork.value},
    Date : ${date.value};
    ''');
  }
}
