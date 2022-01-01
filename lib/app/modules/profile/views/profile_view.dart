import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/ListOrder/TrangThaiModel.dart';
import 'package:v_tech/app/modules/profile/ProfileModel.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  Future<void>? launched;
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hồ sơ cá nhân'),
      ),
      backgroundColor: CustomColor.colorBG,
        body: SafeArea(
          child:Obx(()=>
            controller.isLoading.value == true ?
                Center(child: CircularProgressIndicator(),):
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            child: Image.asset('assets/images/virus.png'),
                          ),
                          CircleAvatar(
                            radius: ScreenSize.height/6,
                            backgroundImage: AssetImage('assets/icons/vsofh.png'),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.person, color: Colors.blue,size: 12.0,),
                                    SizedBox(width: 6.0,),
                                    Container(
                                      child: Text(
                                        'Họ tên: ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle( color: Colors.black, fontSize: 14.0),
                                      ),
                                    ),
                                    Container(
                                        width: Get.width / 2,
                                        child:  Text(
                                          '${controller.profileModel.ten}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.blue,size: 12.0,),
                                SizedBox(width: 6.0,),
                                Container(
                                  child: Text(
                                    'Số điện thoại: ',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle( color: Colors.black, fontSize: 14.0),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '${controller.profileModel.dienThoai}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: (){
                                  launched = _makePhoneCall('tel:${controller.profileModel.dienThoai}');
                                },
                                icon: Icon(Icons.phone, color: Colors.blue,)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.email, color: Colors.blue,size: 12.0,),
                                    SizedBox(width: 6.0,),
                                    Container(
                                      child: Text(
                                        'Email: ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle( color: Colors.black, fontSize: 14.0),
                                      ),
                                    ),
                                    Container(
                                      width: Get.width / 2,
                                      child: Text(
                                        '${controller.profileModel.email}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.amp_stories, color: Colors.blue,size: 12.0,),
                                  SizedBox(width: 6.0,),
                                  Container(
                                    child: Text(
                                      'Trạng thái dịch vụ: ',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle( color: Colors.black, fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                              _buildStatus(context, '${controller.profileModel.trangThaiHoaDonDichVuMacDinh}',controller.profileModel, controller.trangThaiList),
                            ],
                          )
                      ),
                      Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // ignore: deprecated_member_use
                          child:
                          // ignore: deprecated_member_use
                          FlatButton(
                            child:Text('ĐỔI MẬT KHẨU', style: TextStyle(color: CustomColor.titleTextColorBlue),),
                            onPressed: (){
                              displayUpdatePassword();
                            },
                            // ignore: deprecated_member_use
                          )
                      )
                    ],
                  ),
                )
          )
        ),
    );
  }
  Widget _buildStatus(BuildContext context, var trangThai,ProfileModel p, List<TrangThaiModel> lst) {
    String res = "";
    for(int i = 0; i< lst.length; i++){
      if(trangThai == lst[i].ma){
        res = lst[i].ten!;
      }
    }
    return Flexible(
        child: OutlinedButton(
          onPressed: (){displayStatusType(p, trangThai);},
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
          ),
          child: Text("${res}"),
        )
    );
  }
  void displayStatusType(ProfileModel p, String ma) {
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
              child: ListView.builder(
                  itemCount: controller.trangThaiList.length,
                  itemBuilder: (context, index){
                    if(ma == controller.trangThaiList[index].ma){
                      return ListTile(
                        leading: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.cyanAccent[400],
                        ),
                        title: Text(
                          "${controller.trangThaiList[index].ten}",
                          style: TextStyle(fontWeight: FontWeight.bold,  color: Colors.cyanAccent[400]),
                        ),
                        onTap: (){Get.back();},
                      );
                    }
                    return ListTile(
                      leading: Icon(
                          Icons.keyboard_arrow_right
                      ),
                      title: Text(
                          "${controller.trangThaiList[index].ten}"
                      ),
                      onTap: ()async{
                       await controller.UpdateProfile(p, controller.trangThaiList[index].ma);
                      },
                    );
                  }
              )
          )
      ),
    );
  }
  void displayUpdatePassword() {
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
                        'ĐỔI MẬT KHẨU',
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
                          'Để cập nhật mật khẩu, bạn vui lòng điền các thông tin bên dưới',
                          style: TextStyle(color: Colors.grey)
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      controller: controller.textControllerConfirmPasswordNew,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          hintText: 'Mật khẩu mới',
                          hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: CustomColor.minHandEndColor)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      controller: controller.textControllerPasswordNew,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.check),
                          hintText: 'Nhập lại mật khẩu mới',
                          hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: CustomColor.minHandEndColor)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      controller: controller.textControllerPasswordOld,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key_outlined),
                          hintText: 'Nhập lmật khẩu cũ',
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
                              onPressed: ()async{
                                await controller.UpdatePass();
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
