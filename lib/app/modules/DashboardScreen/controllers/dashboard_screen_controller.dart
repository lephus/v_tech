import 'package:get/get.dart';
import 'package:v_tech/app/modules/DashboardScreen/providers/dashboard_screen_provider.dart';

class DashboardScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void GetDataDashboard(var storeID, var fromDate, var toDate, var enterpriseID){
    DashboardScreenProvider().getDataDashboard(
        storeID,
        fromDate,
        toDate,
        enterpriseID
    ).then((resp){
      print(resp.body);
    }).onError((error, stackTrace) => null);
  }
}
