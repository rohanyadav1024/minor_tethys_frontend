import 'package:tethys/modules/login/login_model.dart';

abstract class LoginRepo {
  Future<LoginModel> login(Map data);
}
