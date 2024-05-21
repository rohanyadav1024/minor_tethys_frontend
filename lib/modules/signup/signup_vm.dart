import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/signup/signup_repo/signup_repo_impl.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';

class SignupVM extends GetxController {
  SignupRepoImpl suri = SignupRepoImpl();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController roleCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future<void> signup(BuildContext context) async {
    var data = {};

    data['name'] = nameCtrl.text;
    data['email'] = emailCtrl.text;
    debugPrint(emailCtrl.text);
    data['role'] = roleCtrl.text == 'Stock Manager'
        ? 1
        : roleCtrl.text == 'Product Manager'
            ? 2
            : 3;
    data['phone'] = phoneCtrl.text;
    data['password'] = passwordCtrl.text;

    debugPrint(data.toString());

    await suri.signup(data).then(
      (res) {
        if (res.status == "200") {
          ScaffoldMessenger.of(context).showSnackBar(
            appSnackbar(
              msg: 'Signup request sent successfully',
              color: AppColors.snackBarColorSuccess,
            ),
          );
          Get.offNamed(AppRoutes.loginView);
        } else {
          debugPrint(res.detail);
          ScaffoldMessenger.of(context).showSnackBar(
            appSnackbar(
              msg: res.detail,
              color: AppColors.snackBarColorFailure,
            ),
          );
        }
      },
    );
  }
}
