
import 'package:get/get.dart';

class UserQueriesController extends GetxController {
  var expandedStatus = <bool>[].obs;
  var openStatus = <bool>[].obs;

  List<String> queries = [
    'Query from User 1',
    'Query from User 2',
    'Query from User 3',
    'Query from User 4',
    'Query from User 5',
    'Query from User 6',
    'Query from User 7',
    'Query from User 8',
    'Query from User 9',
    'Query from User 10',
  ];

  @override
  void onInit() {
    super.onInit();
    expandedStatus.assignAll(List<bool>.generate(10, (index) => false));
    openStatus.assignAll(List<bool>.generate(10, (index) => true));
  }

  void toggleExpandedStatus(int index) {
    expandedStatus[index] = !expandedStatus[index];
  }

  void toggleOpenStatus(int index) {
    openStatus[index] = !openStatus[index];
  }
}
