import 'package:get/get.dart';
import 'package:recepie_task/config/database.dart';
import 'package:recepie_task/config/http_config.dart';
import 'package:recepie_task/config/product_model.dart';

class HomePageController extends GetxController {
  RxBool isButtonClicked = false.obs;
  final count = 0.obs;
  List<String> servicesList = ["one", "Two", "Thee"];
  List<int> countsList = [1, 0, 0].obs;

  @override
  void onInit() async {
    super.onInit();
    HttPConfig().getProductData();
  }

  updateText(ProductModel model, bool isIncrement) {
    DbManager().updateModel(model, isIncrement);
    // if (model.quantity == 0) {
    //   isButtonClicked.value = true;
    // }
    update();
  }

  changeButton(ProductModel model, bool isIncrement) {
    DbManager().updateModel(model, isIncrement);
    update();
  }

  increment(int countValue) {
    print(countValue);
    countsList[countValue]++;
    update();
  }

  decrement(int countValue) {
    print(countValue);
    countsList[countValue]--;
    if (count.value == 1) isButtonClicked.value = true;
    update();
  }
}
