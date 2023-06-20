import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/AppBarLocationText.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {

  String locationText = "Colombo";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: AppBar(
          title:  AppBarLocationText(locationText: locationText),
          automaticallyImplyLeading: false,
        ),
        body:
            
            GridView.count(
              crossAxisCount: 2,
              children: List.generate(100, (index) {
                return Center(
                  child: Text(
                    'Item $index',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
              );
              }),
            ),
      ),
    );
  }
}
