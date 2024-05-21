import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/login/login_model.dart';
import 'package:tethys/modules/login/login_repo/login_repo_impl.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';

class LoginVM extends GetxController {
  LoginRepoImpl lri = LoginRepoImpl();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future<void> login({required BuildContext context}) async {
    var data = {};

    data['username'] = usernameCtrl.text.trim();
    data['password'] = passwordCtrl.text.trim();

    debugPrint(data.toString());

    await lri.login(data).then(
      (res) async {
        if (res.status == '200') {
          await storeInSecuredStorage(res);
          if (res.user!.role == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackbar(
                msg: 'Successfully Logged In!',
                color: AppColors.snackBarColorSuccess,
              ),
            );
            Get.offNamed(AppRoutes.ownerHome);
          } else if (res.user!.isActive == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackbar(
                msg: 'Successfully Logged In!',
                color: AppColors.snackBarColorSuccess,
              ),
            );
            if (res.user!.role == 1) {
              Get.offNamed(AppRoutes.stockMngrHome);
            } else if (res.user!.role == 2) {
              Get.offNamed(AppRoutes.prodMngrHome);
            } else if (res.user!.role == 3) {
              Get.offNamed(AppRoutes.gateKeepHome);
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackbar(
                msg: 'Not Authorized',
                color: AppColors.snackBarColorFailure,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            appSnackbar(
              msg: res.detail,
              color: AppColors.snackBarColorFailure,
            ),
          );
        }
      },
    ).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        appSnackbar(
          msg: 'Something wrong occured',
          color: AppColors.snackBarColorFailure,
        ),
      );
    });
  }

  Future<void> storeInSecuredStorage(LoginModel res) async {
    await SecuredStorage.writeStringValue(
      Keys.token,
      res.accessToken.toString(),
    );
    await SecuredStorage.writeStringValue(
      Keys.name,
      res.user!.name.toString(),
    );
    await SecuredStorage.writeStringValue(
      Keys.email,
      res.user!.email.toString(),
    );
    await SecuredStorage.writeIntValue(
      Keys.role,
      res.user!.role!,
    );
    await SecuredStorage.writeStringValue(
      Keys.phone,
      res.user!.phone.toString(),
    );
    await SecuredStorage.writeIntValue(
      Keys.id,
      res.user!.id!,
    );
  }
}
