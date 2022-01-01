import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/responsive.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    final userNameTextField = TextField(
      onChanged: (value){
      },
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controller.textControllerUserName,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: 'Tên đăng nhập',
          hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CustomColor.minHandEndColor)
          )
      ),
    );
    final phoneTextField = TextField(
      onChanged: (value){
      },
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controller.textControllerPhone,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          hintText: 'Số điện thoại',
          hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CustomColor.minHandEndColor)
          )
      ),
    );
    final emailTextField = TextField(
      onChanged: (value){
      },
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controller.textControllerEmail,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          hintText: 'Email',
          hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CustomColor.minHandEndColor)
          )
      ),
    );
    final nameShopTextField = TextField(
      onChanged: (value){
      },
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controller.textControllerNameShop,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.home),
          hintText: 'Tên cửa hàng',
          hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CustomColor.minHandEndColor)
          )
      ),
    );
    final passwordTextField = Obx(()=> TextField(
      onChanged: (value){
      },
      keyboardType: TextInputType.visiblePassword,
      autofocus: false,
      obscureText: controller.isObscure.value,
      controller: controller.textControllerPassword,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(
                  controller.isObscure.value ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                controller.isObscure.value ?  controller.isObscure.value = false :  controller.isObscure.value = true;
              }),
          prefixIcon: Icon(Icons.vpn_key_rounded),
          hintText: 'Mật khẩu',
          hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CustomColor.minHandEndColor)
          )
      ),
    ));
    final confirmPasswordTextField = Obx(()=> TextField(
      onChanged: (value){
      },
      keyboardType: TextInputType.visiblePassword,
      autofocus: false,
      obscureText: controller.isObscureConfirm.value,
      controller: controller.textControllerConfirmPassword,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(
                  controller.isObscureConfirm.value ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                controller.isObscureConfirm.value ?  controller.isObscureConfirm.value = false :  controller.isObscureConfirm.value = true;
              }),
          prefixIcon: Icon(Icons.check),
          hintText: 'Nhập lại mật khẩu',
          hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CustomColor.minHandEndColor)
          )
      ),
    ));
    final btnRegister = Container(
        width: ScreenSize.width,
        decoration: new BoxDecoration(
          border: Border.all(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(10.0),
          gradient: new LinearGradient(
            colors: GradientColors.sea,
            begin: FractionalOffset.centerRight,
            end: FractionalOffset.centerLeft,
          ),
        ),
        // ignore: deprecated_member_use
        child: Obx(()=>
          controller.isLoading.value == false ?
          // ignore: deprecated_member_use
          FlatButton(
            child:Text('ĐĂNG KÝ', style: TextStyle(color: CustomColor.titleTextColorWhite),),
            onPressed: (){
              controller.Register();
            },
            // ignore: deprecated_member_use
          ) :
          // ignore: deprecated_member_use
          FlatButton(
            child:Text('Loading...', style: TextStyle(color: CustomColor.titleTextColorWhite),),
            onPressed: (){
            },
            // ignore: deprecated_member_use
          )
        )
    );
    final btnCancel = Container(
      width: ScreenSize.width,
      decoration: new BoxDecoration(
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
        child: new Text('QUAY LẠI', style: TextStyle(color: CustomColor.titleTextColorBlue),),
        onPressed: ()async{
          Get.back();
        },
      ),
    );
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (Responsive.isMobile(context))
              Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    child: Container(
                      child: Image.asset('assets/images/background.png'),
                    )
                ),
                Container(
                    alignment: Alignment.center,
                    child: Container(
                      child: Image.asset('assets/images/virus.png'),
                    )
                ),
                Container(
                  alignment: Alignment.center,
                  child: GradientText(
                    'TẠO TÀI KHOẢN VTECH',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                    ),
                    colors: [
                      CustomColor.titleTextColorWhite,
                      CustomColor.titleTextColorWhite,
                    ],
                  ),
                ),
              ],
            ),
            if (Responsive.isDesktop(context) || Responsive.isTablet(context))
              Container(
              alignment: Alignment.center,
              child: GradientText(
                'TẠO TÀI KHOẢN VTECH',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
                colors: [
                  CustomColor.minHandEndColor,
                  CustomColor.minHandStatColor,
                ],
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
                width: ScreenSize.width,
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                alignment: Alignment.center,
                child: userNameTextField
            ),
            SizedBox(height: 10.0,),
            Container(
                width: ScreenSize.width,
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                alignment: Alignment.center,
                child: passwordTextField
            ),
            SizedBox(height: 10.0,),
            Container(
                width: ScreenSize.width,
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                alignment: Alignment.center,
                child: confirmPasswordTextField
            ),
            SizedBox(height: 10.0,),
            Container(
                width: ScreenSize.width,
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                alignment: Alignment.center,
                child: emailTextField
            ),
            SizedBox(height: 10.0,),
            Container(
                width: ScreenSize.width,
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                alignment: Alignment.center,
                child: phoneTextField
            ),
            SizedBox(height: 10.0,),
            Container(
                width: ScreenSize.width,
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                alignment: Alignment.center,
                child: nameShopTextField
            ),
            SizedBox(height: 30.0,),
            Container(
                width: ScreenSize.width,
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                alignment: Alignment.center,
                child: btnRegister
            ),
            SizedBox(height: 14.0,),
            Container(
                width: ScreenSize.width,
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                alignment: Alignment.center,
                child: btnCancel
            ),
            SizedBox(height: 90.0,),
            Container(
                width: ScreenSize.width,
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                alignment: Alignment.center,
                child: Text(
                  'VTECH (@) Copyright 2021',
                  style: TextStyle(fontSize: SizeText.sizeSubTitleText, color: Colors.grey),
                )
            ),
            SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }
}
