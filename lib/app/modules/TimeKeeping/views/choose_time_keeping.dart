import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/TimeKeeping/DivisionModel.dart';
import 'package:v_tech/app/modules/TimeKeeping/controllers/time_keeping_controller.dart';

class ChooseTimeKeeping extends GetView<TimeKeepingController>{
  @override
  Widget build(BuildContext context) {
    final btnConfirm = Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
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
          child: Text('XÁC NHẬN', style: TextStyle(color: CustomColor.titleTextColorWhite),),
          onPressed: ()async{
            controller.ChooseDivision();
          },
        )
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn ca làm"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Obx(()=>
                controller.listChooseTimeKeeping.length == 0 ?
                Center(child: Text("Hiện chưa có ca làm nào cho bạn.", style: TextStyle(color: Colors.grey, fontSize: 16),),):
                Scrollbar(
                    child: ListView.builder(
                        itemCount: controller.listChooseTimeKeeping.length,
                        itemBuilder: (context, index){
                          DivisionModel item = controller.listChooseTimeKeeping[index];
                          return  Obx(()=>GestureDetector(
                            onTap: (){
                              controller.indexSelect.value == index?
                              controller.indexSelect.value = -1:
                              controller.indexSelect.value = index;
                            },
                            child:Card(
                                margin: const EdgeInsets.symmetric( horizontal: 16.0, vertical: 8.0),
                                child:Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child:  ListTile(
                                    leading:controller.indexSelect.value == index ?
                                    Icon(Icons.check_box_rounded, color: Colors.green,):
                                    Icon(Icons.check_box_outline_blank, color: Colors.blue,),
                                    title: Text("${item.caLamViec!.ten}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),),
                                    subtitle: Text("${item.caLamViec!.thoiGianVaoStr} - ${item.caLamViec!.thoiGianVeStr}"),
                                  ),
                                )
                            ),
                          ));
                        }
                    )
                ),
            )
          ),
          Obx(()=>
          controller.indexSelect.value == -1 ?
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Text('Vui lòng chọn ca làm việc !', style: TextStyle(color: Colors.blue),),
          ):
          btnConfirm
          )

        ],
      )
    );
  }

}