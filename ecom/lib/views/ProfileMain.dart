import 'package:ecom/components/ActionButtons.dart';
import 'package:ecom/views/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network('https://i.pinimg.com/736x/9a/64/8a/9a648ac91d323b0931448ab34055f967.jpg'),
            ActionButton(btnTitle: "LOG OUT", onClick: (){
              signout(context);
            },)
        ],
      ),
    ));
  }
}

void signout(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
}
