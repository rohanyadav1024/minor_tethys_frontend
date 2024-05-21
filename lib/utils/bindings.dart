import 'package:get/get.dart';
import 'package:tethys/modules/archive/archive_vm.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_vm.dart';
import 'package:tethys/modules/login/login_vm.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';
import 'package:tethys/modules/signup/signup_vm.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_vm.dart';
import 'package:tethys/utils/pages/info_page.dart';

import '../modules/owner/owner_vm.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginVM());
  }
}

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupVM());
  }
}

class OwnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OwnerVM());
  }
}

class StockMngrBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StockMngrVM());
  }
}

class ProdMngrBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProdMngrVM());
  }
}

class GatekeepBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GatekeeperVM());
  }
}

class ArchiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ArchiveVM());
  }
}

class InfoPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InfoPageVM());
  }
}
