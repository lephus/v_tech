import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';

import '../controllers/confirm_o_t_p_controller.dart';

class ConfirmOTPView extends GetView<ConfirmOTPController> {
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;


    final btnLogin = Container(
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
        child: FlatButton(
          child: Obx(()=>controller.isLoading.value == false ?
            Text('XÁC THỰC', style: TextStyle(color: CustomColor.titleTextColorWhite),):
            Text('Loading...', style: TextStyle(color: CustomColor.titleTextColorWhite),)),
            onPressed: ()async{
               var ok = await controller.ValidateOTP('${data[0]}', '${data[1]}', '${controller.textControllerOTP.text}', '${data[2]}');
                   print(ok);
               ok == true ?
                   showAlertDialog(context) : null;
            },
        )
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.error_outline))
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: Colors.white,
          ),
          child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: ScreenSize.width,
                        alignment: Alignment.center,
                        child: GradientText(
                          'XÁC THỰC TÀI KHOẢN',
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
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: ScreenSize.width,
                        alignment: Alignment.center,
                        child: Text(
                            'Vui lòng nhập mã OTP được gửi về ${data[1]}',
                            style: TextStyle(color: Colors.grey)
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: ScreenSize.width,
                        child: TextField(
                          onChanged: (value){
                          },
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          controller: controller.textControllerOTP,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone_android),
                              hintText: 'Nhập mã OTP',
                              hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
                              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: CustomColor.minHandEndColor)
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                          child:btnLogin
                      )
                    ],
                  ),
                ],
              )
          ),
        ),
    );
  }
  showAlertDialog(BuildContext context) {
    Widget continueButton = TextButton(
      child: Text("Tiếp Tục"),
      onPressed:  ()async{
        Get.offAndToNamed('/login');
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("XÁC THỰC THÀNH CÔNG"),
      content: Text("Tài khoản đã được kích hoạt, Đăng nhập để dùng hệ thống. Xin cảm ơn!"),
      actions: [
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
