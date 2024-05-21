import 'package:tethys/modules/signup/signup_model.dart';

abstract class SignupRepo {
  Future<SignupModel> signup(Map data);
}
