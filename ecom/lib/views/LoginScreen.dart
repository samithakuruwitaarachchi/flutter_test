import 'package:ecom/Services/ApiService.dart';
import 'package:ecom/blocs/LoginBloc.dart';
import 'package:ecom/blocs/LoginEvent.dart';
import 'package:ecom/blocs/LoginFormSubmissionStatus.dart';
import 'package:ecom/blocs/LoginStatus.dart';
import 'package:ecom/components/ActionButtons.dart';
import 'package:ecom/components/PasswordInput.dart';
import 'package:ecom/components/emailInput.dart';
import 'package:ecom/repos/repositories.dart';
import 'package:ecom/views/LandingView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  bool _emailvalidate = false;
  bool _passvalidate = false;

  final _formKey = GlobalKey<FormState>();
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          appRepos: context.read<repositories>(),
        ),
        child:  Form(
          key: _formKey,
          child: Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<LoginBloc, LoginStatus>(builder: (context, state){
                return  Padding(padding: EdgeInsets.all(15),
                child: EmailInputWidget(emailController: _emailController, emailvalidate: _emailvalidate));
                  }),

              BlocBuilder<LoginBloc, LoginStatus>(builder: (context, state){
                return Padding(padding: EdgeInsets.all(15),
                child: PasswordInputWidget(passController: _passController, obscured: _obscured, textFieldFocusNode: textFieldFocusNode, passvalidate: _passvalidate));}),

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
                  }
                }),),
            ],
          ),
          )


        )
        ,
      ),
    );
  }

  void _navigateToDashboardScreen(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainHome()));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LandingPage()));
  }
}
