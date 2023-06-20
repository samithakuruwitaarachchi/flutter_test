import 'package:flutter_test/flutter_test.dart';
import 'package:ecom/Services/ApiService.dart';
import 'package:ecom/repos/repositories.dart';

void main(){

//  login api test
test("Login with valid username and password", ()
    async {
      final appRepos = repositories();
      final response = await appRepos.authUser("john@mail.com", "changeme");
      expect(response, true);
    });
}