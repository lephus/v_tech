import 'package:get/get.dart';

import '../modules/BillOfLadingHistory/bindings/bill_of_lading_history_binding.dart';
import '../modules/BillOfLadingHistory/views/bill_of_lading_history_view.dart';
import '../modules/ConfirmOTP/bindings/confirm_o_t_p_binding.dart';
import '../modules/ConfirmOTP/views/confirm_o_t_p_view.dart';
import '../modules/Customer/bindings/customer_binding.dart';
import '../modules/Customer/views/customer_view.dart';
import '../modules/DashboardScreen/bindings/dashboard_screen_binding.dart';
import '../modules/DashboardScreen/views/dashboard_screen_view.dart';
import '../modules/LineChart/bindings/line_chart_binding.dart';
import '../modules/LineChart/views/line_chart_view.dart';
import '../modules/ListOrder/bindings/list_order_binding.dart';
import '../modules/ListOrder/views/list_order_view.dart';
import '../modules/MyFile/bindings/my_file_binding.dart';
import '../modules/MyFile/views/my_file_view.dart';
import '../modules/OrderAssemble/bindings/order_assemble_binding.dart';
import '../modules/OrderAssemble/views/order_assemble_view.dart';
import '../modules/RecentFiles/bindings/recent_files_binding.dart';
import '../modules/RecentFiles/views/recent_files_view.dart';
import '../modules/Repair/bindings/repair_binding.dart';
import '../modules/Repair/views/SearchBillRepair.dart';
import '../modules/Repair/views/SearchDetailRepair.dart';
import '../modules/Repair/views/repair_view.dart';
import '../modules/Slide/bindings/slide_binding.dart';
import '../modules/Slide/views/slide_view.dart';
import '../modules/StarageDetails/bindings/starage_details_binding.dart';
import '../modules/StarageDetails/views/starage_details_view.dart';
import '../modules/TimeKeeping/bindings/time_keeping_binding.dart';
import '../modules/TimeKeeping/views/accepted_view.dart';
import '../modules/TimeKeeping/views/await_accept_view.dart';
import '../modules/TimeKeeping/views/choose_time_keeping.dart';
import '../modules/TimeKeeping/views/history_time_keeping.dart';
import '../modules/TimeKeeping/views/manage_time_keeping.dart';
import '../modules/TimeKeeping/views/refuse_accept_view.dart';
import '../modules/TimeKeeping/views/time_keeping_view.dart';
import '../modules/WareHouse/bindings/ware_house_binding.dart';
import '../modules/WareHouse/views/ware_house_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/inforProduct/bindings/infor_product_binding.dart';
import '../modules/inforProduct/views/infor_product_view.dart';
import '../modules/instance/bindings/instance_binding.dart';
import '../modules/instance/views/instance_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/permissions/bindings/permissions_binding.dart';
import '../modules/permissions/views/permissions_view.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/product/views/product_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_SCREEN,
      page: () => DashboardScreenView(),
      binding: DashboardScreenBinding(),
    ),
    GetPage(
      name: _Paths.LINE_CHART,
      page: () => LineChartView(),
      binding: LineChartBinding(),
    ),
    GetPage(
      name: _Paths.SLIDE,
      page: () => SlideView(),
      binding: SlideBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER,
      page: () => CustomerView(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: _Paths.MY_FILE,
      page: () => MyFileView(),
      binding: MyFileBinding(),
    ),
    GetPage(
      name: _Paths.RECENT_FILES,
      page: () => RecentFilesView(),
      binding: RecentFilesBinding(),
    ),
    GetPage(
      name: _Paths.STARAGE_DETAILS,
      page: () => StarageDetailsView(),
      binding: StarageDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_O_T_P,
      page: () => ConfirmOTPView(),
      binding: ConfirmOTPBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.INFOR_PRODUCT,
      page: () => InforProductView(),
      binding: InforProductBinding(),
    ),
    GetPage(
      name: _Paths.LIST_ORDER,
      page: () => ListOrderView(),
      binding: ListOrderBinding(),
    ),
    GetPage(
      name: _Paths.WARE_HOUSE,
      page: () => WareHouseView(),
      binding: WareHouseBinding(),
    ),
    GetPage(
      name: _Paths.TIME_KEEPING,
      page: () => TimeKeepingView(),
      binding: TimeKeepingBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_ASSEMBLE,
      page: () => OrderAssembleView(),
      binding: OrderAssembleBinding(),
    ),
    GetPage(
      name: _Paths.PERMISSIONS,
      page: () => PermissionsView(),
      binding: PermissionsBinding(),
    ),
    GetPage(
      name: _Paths.BILL_OF_LADING_HISTORY,
      page: () => BillOfLadingHistoryView(),
      binding: BillOfLadingHistoryBinding(),
    ),
    GetPage(
      name: _Paths.REPAIR,
      page: () => RepairView(),
      binding: RepairBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_REPAIR,
      page: () => SearchBillRepair(),
      binding: RepairBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_DETAIL_REPAIR,
      page: () => SearchDetailRepair(),
      binding: RepairBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_TIME_KEEPING,
      page: () => ChooseTimeKeeping(),
      binding: TimeKeepingBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_TIME_KEEPING,
      page: () => HistoryTimeKeeping(),
      binding: TimeKeepingBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_TIME_KEEPING,
      page: () => ManageTimeKeeping(),
      binding: TimeKeepingBinding(),
    ),
    GetPage(
      name: _Paths.AWAIT_ACCEPT_TIME_KEEPING,
      page: () => AwaitAcceptView(),
      binding: TimeKeepingBinding(),
    ),
    GetPage(
      name: _Paths.ACCEPTED_TIME_KEEPING,
      page: () => AcceptedView(),
      binding: TimeKeepingBinding(),
    ),
    GetPage(
      name: _Paths.REFUSE_ACCEPT_TIME_KEEPING,
      page: () => RefuseAcceptView(),
      binding: TimeKeepingBinding(),
    ),
    GetPage(
      name: _Paths.INSTANCE,
      page: () => InstanceView(),
      binding: InstanceBinding(),
    ),
  ];
}
