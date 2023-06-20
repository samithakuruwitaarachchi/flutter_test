
import 'package:ecom/navControllers/LandingViewController.dart';
import 'package:ecom/views/Cart.dart';
import 'package:ecom/views/MainHome.dart';
import 'package:ecom/views/OrderView.dart';
import 'package:ecom/views/ProfileMain.dart';
import 'package:ecom/views/OrderView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List pages = [
  //   MainHome(),
  //   OrderView(),
  //   CartView(),
  //   ProfileMain(),
  // ];


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GetBuilder<LandingViewController>(
        builder: (controller){
          return  Scaffold(
            body: SafeArea(
              child: IndexedStack(
                index: controller.tabIndex,
                children: [
                  MainHome(),
                  OrderView(),
                  CartView(),
                  ProfileMain(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.red,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Services',
                  backgroundColor: Colors.green,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Cart',
                  backgroundColor: Colors.pink,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                  backgroundColor: Colors.pink,
                ),
              ],
              currentIndex: controller.tabIndex,
              selectedItemColor: Colors.amber[800],
              onTap: controller.changeTabs,
            ),
          );
        },
      ),
    );
  }
}
