import 'package:get/get.dart';

class LandingViewController extends GetxController{
  var tabIndex = 0;
  void changeTabs(int tbIndex){
    tabIndex = tbIndex;
    update();
  }
}