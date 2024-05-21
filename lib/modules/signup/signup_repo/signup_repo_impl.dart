import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/signup/signup_model.dart';
import 'package:tethys/modules/signup/signup_repo/signup_repo.dart';

class SignupRepoImpl extends SignupRepo {
  @override
  Future<SignupModel> signup(Map data) async {
    ApiService apiService = ApiService();
    return signupModelFromJson(
      await apiService.post(Endpoints.employee + Endpoints.create, data),
    );
  }
}
