import 'package:ecom/navControllers/LandingViewController.dart';
import 'package:ecom/navControllers/MainHomeController.dart';
import 'package:ecom/navControllers/OrderController.dart';
import 'package:ecom/navControllers/ProfileController.dart';
import 'package:get/get.dart';

class LandingBiding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LandingViewController>(()=> LandingViewController());
    Get.lazyPut<MainHomeController>(() => MainHomeController());
    Get.lazyPut<OrderPage>(() => OrderPage());
    Get.lazyPut<ProfilePage>(() => ProfilePage());
  }

}