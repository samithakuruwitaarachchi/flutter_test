import 'dart:convert';
import 'package:ecom/blocs/LoginFormSubmissionStatus.dart';
import 'package:ecom/repos/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecom/blocs/LoginEvent.dart';
import 'package:ecom/blocs/LoginStatus.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStatus>{

   final repositories? appRepos;
    LoginBloc({this.appRepos}) : super(LoginStatus());

 // LoginBloc(): super(LoginStatus());

  @override
  Stream<LoginStatus> mapEventToState(LoginEvent event) async*{
    // TODO: implement mapEventToState
    if(event is LoginEmailChanged){
      yield state.copyWith(email: event.email);
    }else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
       try {
         final response = await appRepos?.authUser(event.email, event.password);

         if(response != null){
           try {
             yield state.copyWith(formStatus: SubmissionSuccess("ISTRUE"));
           }catch(e){
           }
         }
       } catch (e) {
       }
    }


  }

}