import 'dart:math';

import 'package:ecom/Services/ApiService.dart';
import 'package:ecom/blocs/LoginBloc.dart';
import 'package:ecom/blocs/LoginEvent.dart';
import 'package:ecom/blocs/LoginFormSubmissionStatus.dart';
import 'package:ecom/blocs/LoginStatus.dart';
import 'package:ecom/components/ActionButtons.dart';
import 'package:ecom/repos/repositories.dart';
import 'package:ecom/views/MainHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/PasswordInput.dart';
import '../components/emailInput.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passController = TextEditingController();
    final textFieldFocusNode = FocusNode();
    bool _obscured = true;
    bool _emailvalidate = false;
    bool _passvalidate = false;

    final apiService = ApiService();
    final _formKey = GlobalKey<FormState>();

    void _toggleObscured() {
      setState(() {
        _obscured = !_obscured;
        if (textFieldFocusNode.hasPrimaryFocus)
          return; // If focus is on text field, dont unfocus
        textFieldFocusNode.canRequestFocus =
        false; // Prevents focus if tap on eye
      });
    }

    Future<void> _authUser(email, pass) async {
      if(await apiService.doLogin(email, pass)){
        _navigateToDashboardScreen(context);
      }
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
            body: BlocProvider(
              create: (context) => LoginBloc(
                appRepos: context.read<repositories>(),
              ),
              child:
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 105, 20, 0),
                child: SingleChildScrollView(
                    child:

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocBuilder<LoginBloc, LoginStatus>(builder: (context, state){
                             return  EmailInputWidget(emailController: _emailController, emailvalidate: _emailvalidate);}),

                          BlocBuilder<LoginBloc, LoginStatus>(builder: (context, state){
                            return PasswordInputWidget(passController: _passController, obscured: _obscured, textFieldFocusNode: textFieldFocusNode, passvalidate: _passvalidate);}),

                          BlocListener<LoginBloc, LoginStatus>
                            (listener: (context, state) {
                            if(state.formStatus is SubmissionSuccess){
                              print("navigation print called" );
                              _navigateToDashboardScreen(context);
                            }
                          },
                          child:  BlocBuilder<LoginBloc, LoginStatus>(builder: (context, state){

                            if(state.formStatus is FormSubmitting){
                              return  CircularProgressIndicator();
                            }else {
                              return  Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: ActionButton(btnTitle: 'Login', onClick: () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<LoginBloc>().add(LoginSubmitted(email: _emailController.text, password: _passController.text));
                                        }
                                      },),
                                    ),
                                  ),
                                ],
                              );

                              // ElevatedButton(
                              //   style: ElevatedButton.styleFrom(
                              //     primary: Color(AppColors.colorYellow),
                              //     minimumSize: const Size(100, 52),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius:
                              //       BorderRadius.circular(8), // <-- Radius
                              //     ),
                              //   ),
                              //   child: Text(
                              //     AppStrings.loginButtonText,
                              //     style: const TextStyle(
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.w400,
                              //     ),
                              //   ),
                              //   onPressed: () {
                              //     // setState(() {
                              //     //   if (_emailController.text.isEmpty) {
                              //     //     _emailvalidate = true;
                              //     //   } else {
                              //     //     if (!RegExp(
                              //     //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              //     //         .hasMatch(_emailController.text)) {
                              //     //       _emailvalidate = true;
                              //     //     } else {
                              //     //       if (_passController.text.isEmpty ||
                              //     //           _passController.text.length < 8) {
                              //     //         _passvalidate = true;
                              //     //       } else {
                              //     //         _emailvalidate = false;
                              //     //         _passvalidate = false;
                              //     //
                              //     //         _authUser(_emailController.text,
                              //     //             _passController.text);
                              //     //       }
                              //     //     }
                              //     //   }
                              //     // }
                              //     // );
                              //   },
                              // );
                            }
                          }),),



                        ],
                      ),
                    )


                ),
              )
            ),




        )
    );

  }
}

void _navigateToDashboardScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainHome()));
}
