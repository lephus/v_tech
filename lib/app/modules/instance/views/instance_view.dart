import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';

import '../controllers/instance_controller.dart';

class InstanceView extends GetView<InstanceController> {
  @override
  Widget build(BuildContext context) {
    final btnLogin = Container(
        width: Get.width,
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
        child: FlatButton(
          child: Obx(()=>controller.isLoading.value == false ?
          Text('XÁC NHẬN', style: TextStyle(color: CustomColor.titleTextColorWhite),):
          Text('Loading...', style: TextStyle(color: CustomColor.titleTextColorWhite),)),
          onPressed: ()async{
            controller.truncatePassword();
          },
        )
    );
    final passwordTextField = Obx(()=> TextField(
      onChanged: (value){
      },
      keyboardType: TextInputType.visiblePassword,
      autofocus: false,
      obscureText: controller.isObscure.value,
      controller: controller.textEditingControllerPassword,
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Khẩn cấp'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 28,),
          Expanded(
            child:  Column(
              children: [
                Text("Vui lòng điền mật khẩu để tiếp tục!"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 28),
                  child: passwordTextField,
                )
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 28),
            child: btnLogin,
          )
        ],
      )
    );
  }
}
