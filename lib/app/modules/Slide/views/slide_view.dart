import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/permissions/controllers/permissions_controller.dart';

import '../controllers/slide_controller.dart';

class SlideView extends GetView<SlideController> {
  PermissionsController permissionsController = new PermissionsController();
  @override
  Widget build(BuildContext context) {
    List<Widget> listMenu(){
      List<Widget> dataMenu= [];
      dataMenu.add( DrawerHeader(
        padding: EdgeInsets.all(SizeText.defaultPadding*2.5),
        child: Image.asset("assets/icons/vsofh.png"),
      ));
      dataMenu.add( DrawerListTile(
        title: "Dashboard",
        svgSrc: "assets/icons/menu_dashbord.svg",
        press: () {
          Get.back();
        },
      )); // Dashboard
      if(permissionsController.CheckPermissionFunction(permissionsController.BAN_HANG)){
        dataMenu.add( DrawerListTile(
          title: "Danh sách đơn hàng",
          svgSrc: "assets/icons/menu_tran.svg",
          press: () {
            Get.toNamed('/list-order');
          },
        )); // Hoa don
      }
      if(permissionsController.CheckPermissionFunction(permissionsController.SAN_PHAM)){
        dataMenu.add( DrawerListTile(
          title: "Sản phẩm",
          svgSrc: "assets/icons/menu_doc.svg",
          press: () {
            Get.toNamed('/product');
          },
        )); // San Pham
      }
      if(permissionsController.CheckPermissionFunction(permissionsController.KHACH_HANG)){
        dataMenu.add( DrawerListTile(
          title: "Khách hàng",
          svgSrc: "assets/icons/menu_profile.svg",
          press: () {
            Get.toNamed('/customer');
          },
        )); // Khach hang
      }
      if(permissionsController.CheckPermissionFunction(permissionsController.KHO_HANG)){
        dataMenu.add( DrawerListTile(
          title: "Kho",
          svgSrc: "assets/icons/menu_task.svg",
          press: () {
            Get.toNamed('/ware-house');
          },
        )); // Kho hang
      }
      if(permissionsController.CheckPermissionFunction(permissionsController.DON_HANG_LAP_RAP)){
        dataMenu.add( DrawerListTile(
          title: "Đơn hàng lắp ráp",
          svgSrc: "assets/icons/menu_store.svg",
          press: () {
            Get.toNamed('/order-assemble');
          },
        )); // Don hang lap rap
      }
      if(permissionsController.CheckPermissionFunction(permissionsController.LICH_SU_VAN_DON)){
        dataMenu.add( DrawerListTile(
          title: "Lịch sử vận đơn",
          svgSrc: "assets/icons/Product.svg",
          press: () {
            Get.toNamed('/bill-of-lading-history');
          },
        ));
      }
      if(permissionsController.CheckPermissionFunction(permissionsController.PHIEU_SUA_CHUA)){
        dataMenu.add( DrawerListTile(
          title: "Phiếu sửa chữa",
          svgSrc: "assets/icons/Receipts.svg",
          press: () {
            Get.toNamed('/repair');
          },
        ));
      }


      dataMenu.add( DrawerListTile(
        title: "Chấm công",
        svgSrc: "assets/icons/menu_setting.svg",
        press: () {
          Get.toNamed('/time-keeping');
        },
      )); // Cham cong
      dataMenu.add( DrawerListTile(
        title: "Khẩn cấp",
        svgSrc: "assets/icons/menu_notification.svg",
        press: () async {
          Get.toNamed('/instance');
        },
      )); // Khan cap
      dataMenu.add( DrawerListTile(
        title: "Đăng xuất",
        svgSrc: "assets/icons/logout.svg",
        press: () async {
          showAlertDialog(context);
        },
      )); // Log out
      return dataMenu;
    }


    return Drawer(
      child: ListView(
        children: listMenu()
      ),
    );
  }




  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Hủy"),
      onPressed:  () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Đăng Xuất"),
      onPressed:  ()async{
        var check = await controller.RemoveTokenFirebase();
        if(check == true){
          Get.offNamed("/login");
        }
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("ĐĂNG XUẤT"),
      content: Text("Bạn chắc chắn muốn đăng xuất?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: CustomColor.titleTextColorBlue,
        height: 18,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: CustomColor.titleTextColorBlue,
            fontSize: SizeText.sizeTitleText
        ),
      ),
    );
  }
}