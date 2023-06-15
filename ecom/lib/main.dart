import 'package:ecom/constants/app_strings.dart';
import 'package:ecom/views/LoginView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginView(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passController = TextEditingController();
    final textFieldFocusNode = FocusNode();
    bool _obscured = true;
    bool _emailvalidate = false;
    bool _passvalidate = false;

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 105, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(
                        color: Color(AppColors.colorWhite),
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        errorText: _emailvalidate
                            ? 'Please enter a valid email address.'
                            : null,
                        hintText: AppStrings.hintTextEmail,
                        hintStyle: TextStyle(
                          color: Color(AppColors.colorGray3),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        fillColor: Color(AppColors.colorBlue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )

          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //
          //
          //
          //     ],
          //   ),
          // ),
        )
    );


  }
}
