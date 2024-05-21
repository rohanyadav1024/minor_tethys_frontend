// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/archive/archive_views/archive_view.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_views/gatekeeper_home.dart';
import 'package:tethys/modules/login/login_views/login_view.dart';
import 'package:tethys/modules/login/login_views/splash_view.dart';
import 'package:tethys/modules/owner/views/owner_home_view.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/pm_inventory.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/prod_mngr_home.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/return_materials.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/update_consumptions_view.dart';
import 'package:tethys/modules/signup/signup_view.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_views/issue_materials.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_views/sm_inventory.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_views/stock_mngr_home.dart';
import 'package:tethys/utils/bindings.dart';
import 'package:tethys/utils/pages/info_page.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'resources/app_routes.dart';

void main() {
  SecuredStorage.initiateSecureStorage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(481, 926),
      builder: (context, child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(),
            home:
                // ProdMngrHome(),
                SplashView(),
            getPages: [
              GetPage(
                name: AppRoutes.loginView,
                page: () => const LoginView(),
                binding: LoginBinding(),
              ),
              GetPage(
                name: AppRoutes.signupView,
                page: () => const SignupView(),
                binding: SignupBinding(),
              ),
              GetPage(
                name: AppRoutes.ownerHome,
                page: () => OwnerHome(),
                binding: OwnerBinding(),
              ),
              GetPage(
                name: AppRoutes.stockMngrHome,
                page: () => StockMngrHome(),
                binding: StockMngrBinding(),
              ),
              GetPage(
                  name: AppRoutes.smInventory,
                  page: () => SmInventory(),
                  binding: StockMngrBinding(),
                  transition: Transition.zoom,
                  transitionDuration: Duration(milliseconds: 200)),
              GetPage(
                name: AppRoutes.prodMngrHome,
                page: () => ProdMngrHome(),
                binding: ProdMngrBinding(),
              ),
              GetPage(
                  name: AppRoutes.pmInventory,
                  page: () => PmInventory(),
                  binding: ProdMngrBinding(),
                  transition: Transition.zoom,
                  transitionDuration: Duration(milliseconds: 200)),
              GetPage(
                name: AppRoutes.gateKeepHome,
                page: () => GateKeeperHome(),
                binding: GatekeepBinding(),
              ),
              GetPage(
                  name: AppRoutes.issueMaterials,
                  page: () => IssueMaterials(),
                  binding: StockMngrBinding(),
                  transition: Transition.zoom,
                  transitionDuration: Duration(milliseconds: 200)),
              GetPage(
                  name: AppRoutes.returnMaterials,
                  page: () => ReturnMaterials(),
                  binding: ProdMngrBinding(),
                  transition: Transition.zoom,
                  transitionDuration: Duration(milliseconds: 200)),
              GetPage(
                  name: AppRoutes.updateConsumptions,
                  page: () => UpdateConsumtionView(),
                  binding: ProdMngrBinding(),
                  transition: Transition.zoom,
                  transitionDuration: Duration(milliseconds: 200)),
              GetPage(
                  name: AppRoutes.archives,
                  page: () => ArchiveView(),
                  binding: ArchiveBinding(),
                  transition: Transition.zoom,
                  transitionDuration: Duration(milliseconds: 200)),
              GetPage(
                  name: AppRoutes.infoPage,
                  page: () => InfoPage(),
                  binding: InfoPageBinding(),
                  transition: Transition.zoom,
                  transitionDuration: Duration(milliseconds: 200)),
            ]);
      },
    );
  }
}
