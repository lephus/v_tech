import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/product/productInfo.dart';

import '../controllers/product_controller.dart';
class ProductView extends GetView<ProductController> {
  final oCcy = new NumberFormat("#,###", "en_US");
  @override
  Widget build(BuildContext context) {
    final searchTextField = TextField(
      onChanged: (value) {},
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controller.textControllerSearchProduct,
      decoration: InputDecoration(
          hintText: 'Tên sản phẩm...',
          hintStyle: TextStyle(
              fontSize: 12.0, color: CustomColor.pageDarkBackgroundColor),
          contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CustomColor.subTextColorBlue)
          )
      ),
    );

    void displayFill(){
      Get.bottomSheet(
          Container(
              height: ScreenSize.height/2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
                color: Colors.white,
              ),
              child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: ScreenSize.width,
                                    decoration: new BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      child: Obx(() => Text(
                                        '${controller.listType[controller.selected.value]['ten']}',
                                        style: TextStyle(color: CustomColor
                                            .titleTextColorBlue),)),
                                      onPressed: () async {
                                        displaySelectDow();
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Obx(()=>Container(
                                      alignment: Alignment.center,
                                      child: Text("Tổng ${controller.totalRecords.value} Sản Phẩm"),
                                    ))
                                ),
                              ],
                            )
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: searchTextField
                                ),
                                Expanded(
                                  flex: 1,
                                  // ignore: deprecated_member_use
                                  child: FlatButton(
                                    onPressed: ()async{
                                      await controller.GetDataTableProduct(controller.textControllerSearchProduct.text);
                                      Get.back();
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column( // Replace with a Row for horizontal icon + text
                                      children: <Widget>[
                                        Icon(Icons.filter_list_alt),
                                        Text("Lọc")
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  )
              )
          )
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Danh sách sản phẩm"),
          actions: [
            IconButton(onPressed: (){displayFill();}, icon: Icon(Icons.filter_list_alt)),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: searchTextField
                                  ),
                                  Expanded(
                                    flex: 1,
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      onPressed: ()async{
                                        await controller.GetDataTableProduct(controller.textControllerSearchProduct.text);
                                      },
                                      child: Column( // Replace with a Row for horizontal icon + text
                                        children: <Widget>[
                                          Icon(Icons.search),
                                          Text("Tìm kiếm")
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                      )
                    ],
                  )
              ),
              Expanded(
                child: Obx(()=>
                controller.isLoading.value ?
                Center(child: CircularProgressIndicator()) :
                Scrollbar(child: RefreshingView(
                    controller: controller.refreshController,
                    onRefresh: controller.onRefresh,
                    onLoadmore: controller.onLoadMore,
                    child:ListView.builder(
                      shrinkWrap: true,
                        itemCount: controller.listDataTable.length,
                        itemBuilder:  (context, index) {
                          ProductModel item = controller.listDataTable[index];
                          return Card(
                            child: ListTile(
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('ID: ${item.id}'),
                                  Text('Tồn: ${item.tonKho}'),
                                ],
                              ),
                              leading: item.anhSanPham == "" || item.anhSanPham == null ?
                              Image.asset('assets/icons/paste.png') :
                              Image.network('item.anhSanPham '),
                              title: Text(
                                  '${item.ten}'),
                              subtitle: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Lẻ: ${oCcy.format(item.giaBan)} VND'),
                                    Text('Buôn: ${oCcy.format(item.giaBanBuon)} VND'),
                                    Text('Thân: ${oCcy.format(item.giaBanKhachThan)} VND'),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Get.toNamed('/infor-product?id=${item.id}');
                              },
                            ),
                          );
                        }
                    )
                    )
                  )
                ),
              )
            ],
          )
        ),
    );
  }
  void displaySelectDow() {
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
              padding: const EdgeInsets.all(16.0),
              itemCount: controller.listType.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    child: Container(
                      decoration: new BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Icon(Icons.send, color: CustomColor.titleTextColorBlue, size: SizeText.sizeTitleText,),
                          SizedBox(width: 16.0,),
                          Text('${controller.listType[index]['ten']}', style: TextStyle(color: CustomColor.titleTextColorBlue, fontSize: SizeText.sizeTitleText),),
                        ],
                      ),
                    ),
                    onTap: ()async{
                      controller.selected.value = index;
                      Get.back();
                    }
                );
              },
            )
        ),
      ),
    );
  }
}
