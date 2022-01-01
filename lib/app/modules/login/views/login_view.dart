import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import '../controllers/login_controller.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
class LoginView extends GetView<LoginController> {
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
    final loginWithGoogleOrFacebook = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
        "Đăng nhập bằng ",
        style: TextStyle(color: CustomColor.pageDarkBackgroundColor, fontSize: SizeText.sizeSubTitleText),
        ),
        IconButton(
          icon: Image.asset('assets/icons/facebook.png'),
          iconSize: 50,
          onPressed: () {},
        ),
        IconButton(
          icon: Image.asset('assets/icons/google.png'),
          iconSize: 50,
          onPressed: () {},
        )
      ],
    );
    final btnForgotPassword = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: SizeText.sizeSubTitleText),
            ),
            onPressed: () {
              Get.toNamed('/register');
            },
            child: const Text('Đăng ký'),
          ),
        ),
        Container(
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: SizeText.sizeSubTitleText),
            ),
            onPressed: () {displayForgotPassword();},
            child: const Text('Quên mật khẩu'),
          ),
        ),
      ],
    );
    // ignore: deprecated_member_use
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
              Text('ĐĂNG NHẬP', style: TextStyle(color: CustomColor.titleTextColorWhite),):
              Text('Loading...', style: TextStyle(color: CustomColor.titleTextColorWhite),)),
              onPressed: ()async{
                var acceptLogin = await controller.actionLogin();
                if(acceptLogin == true){
                  await controller.postTokenFirebase();
                  Get.offAndToNamed('/home');
                }
            },
        )
      );
    return Scaffold(
      backgroundColor: CustomColor.colorBG,
      body: Center(
        child:Obx(()=>
          controller.checkConnectInternet.value == false ?
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 30.0 , horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: ScreenSize.width-50,
                  height: ScreenSize.height/4-20,
                  child: Image.asset('assets/icons/vsofh.png'),
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: GradientText(
                        'Giải pháp cho cộng đồng',
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
                    Container(
                      alignment: Alignment.center,
                      child: GradientText(
                        'Mobile',
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
                  ],
                ),
                SizedBox(height: 16.0,),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                    width: ScreenSize.width,
                    alignment: Alignment.center,
                    child:Text("Không có kết nối Internet. Vui lòng thử lại sau!", style: TextStyle(color: Colors.red, fontSize: 16.0),)
                ),
                SizedBox(height: 16.0,),
                Container(
                    width: ScreenSize.width,
                    alignment: Alignment.center,
                    child:Text("©${controller.year} Copyright Vsofh", style: TextStyle(color: Colors.grey[400], fontSize: 10.0),)
                ),
              ],
            ),
          )
              :
          controller.isAutoLogin.value ?
              Container(
                width: Get.width/3,
                height: Get.height/4,
                child: Image.asset('assets/icons/vsofh.png'),
              ):
              SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 30.0 , horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: ScreenSize.width-50,
                  height: ScreenSize.height/4-20,
                  child: Image.asset('assets/icons/vsofh.png'),
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: GradientText(
                        'Giải pháp cho cộng đồng',
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
                    Container(
                      alignment: Alignment.center,
                      child: GradientText(
                        'Mobile',
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
                  ],
                ),
                SizedBox(height: 12.0,),
                Container(
                    width: ScreenSize.width,
                    alignment: Alignment.center,
                    child: userNameTextField
                ),
                SizedBox(height: 12.0,),
                Container(
                    width: ScreenSize.width,
                    alignment: Alignment.center,
                    child:passwordTextField
                ),
                Container(
                    width: ScreenSize.width,
                    alignment: Alignment.center,
                    child: btnForgotPassword
                ),
                SizedBox(height: 12.0,),
                Container(
                    width: ScreenSize.width,
                    alignment: Alignment.center,
                    child: btnLogin
                ),
                SizedBox(height: 12.0,),
                Container(
                    width: ScreenSize.width,
                    alignment: Alignment.center,
                    child:loginWithGoogleOrFacebook
                ),
                SizedBox(height: 16.0,),
                Container(
                    width: ScreenSize.width,
                    alignment: Alignment.center,
                    child:Text("©${controller.year} Copyright Vsofh", style: TextStyle(color: Colors.grey[400], fontSize: 10.0),)
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
  void displayForgotPassword() {
    Get.bottomSheet(
      Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: GradientText(
                        'Quên mật khẩu',
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
                      alignment: Alignment.center,
                      child: Text(
                        'Bạn vui lòng điền Email đã đăng ký, hệ thống sẽ xác thực tài khoản và gửi bạn mã OTP qua Email. Xin cảm ơn!',
                        style: TextStyle(color: Colors.grey)
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
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
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ignore: deprecated_member_use
                          RaisedButton(
                            child: Text(
                              'XÁC NHẬN',
                              style: TextStyle(color: CustomColor.titleTextColorBlue),),
                            onPressed: () {
                            },
                          )
                        ],
                      )
                    )
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}
