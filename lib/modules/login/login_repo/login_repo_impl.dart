import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/login/login_repo/login_repo.dart';
import 'package:tethys/modules/login/login_model.dart';

class LoginRepoImpl extends LoginRepo {
  ApiService apiService = ApiService();

  @override
  Future<LoginModel> login(Map data) async {
    return LoginModelFromJson(
      await apiService.post(Endpoints.login, data),
    );
  }
}
