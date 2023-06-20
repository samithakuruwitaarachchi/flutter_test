
import 'package:ecom/blocs/LoginFormSubmissionStatus.dart';

class LoginStatus {

 final String email;
 bool get isValidUsername => email.length > 3;
 final String password;
 bool get isValidPassword => password.length > 6;

 final LoginFormSubmissionStatus formStatus;

   LoginStatus({
     this.email = '',
     this.password = '',
     this.formStatus = const InitialFormStatus(),
  });

 LoginStatus copyWith({
   String? email,
   String? password,
   LoginFormSubmissionStatus? formStatus,
 }) {
   return LoginStatus(
     email: email ?? this.email,
     password: password ?? this.password,
     formStatus: formStatus ?? this.formStatus,
   );
 }


}