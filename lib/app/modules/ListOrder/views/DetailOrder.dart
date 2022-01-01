import 'package:flutter/material.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v_tech/app/modules/ListOrder/OrderModel.dart';
import 'package:v_tech/app/modules/ListOrder/controllers/list_order_controller.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';
// ignore: must_be_immutable
class DetailOrder extends StatefulWidget {
  DonHangModel donHangModel;
  ListOrderController controller;
  DetailOrder({Key? key,  required this.donHangModel, required this.controller}) : super(key: key);
  @override
  _DetailOrderState createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  List<int> idCheck = [];
  @override
  Widget build(BuildContext context) {
    Future<void>? launched;
    Future<void> _makePhoneCall(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    void changeCheck(int id, int id_log, int id_HoaDon,int id_SanPham){
      if(id_log == 0){
        idCheck.add(id);
        widget.controller.SaveLog( id_HoaDon, id_SanPham, widget.donHangModel.idKhachHang!);
      }
    }
    bool isSelect(int id){
      for(int i=0; i<idCheck.length; i++){
        if(idCheck[i] == id){
          return true;
        }
      }
      return false;
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text("Vui lòng chắc chắn trước lựa chọn nhặt hàng -- hủy nhặt hàng, không spam dưới mọi hình thức.",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Divider(color: Colors.black,),
                  SizedBox(height: 12.0,),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: VerticalTextCell(
                          displayDivider: true,
                          title: 'ID hóa đơn',
                          content: '${widget.donHangModel.id ?? ""}',
                        ),
                      ),
                      Expanded(
                        child: VerticalTextCell(
                          displayDivider: true,
                          title: 'Số lượng',
                          content: '${widget.donHangModel.sanPhamDichVu!.length}',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: VerticalTextCell(
                          displayDivider: true,
                          title: 'Tên Khách',
                          content: '${widget.donHangModel.tenKhachHang ?? 0}',
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 18),
                              textStyle: TextStyle(
                                  color: Colors.black)),
                          onPressed: (){
                            launched = _makePhoneCall('tel:${widget.donHangModel.sdtKhachHang}');
                          },
                          child: Text('${widget.donHangModel.sdtKhachHang} 📞', style: TextStyle(color: Colors.black),),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: VerticalTextCell(
                          displayDivider: true,
                          title: 'Cửa hàng',
                          content: '${widget.donHangModel.cuaHangInfo!.ten ??
                              0}',
                        ),
                      ),
                      Expanded(
                        child: VerticalTextCell(
                          displayDivider: true,
                          title: 'Tổng',
                          content: '${convertMoney(widget.donHangModel.tongTienHoaDon!)}',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: VerticalTextCell(
                          displayDivider: true,
                          title: 'Ghi chú: ',
                          content: '${widget.donHangModel.ghiChuKhachHang ?? ""}',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0,),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Text("Sản phẩm")
                      ),
                      Expanded(
                          child: Text("Đơn giá")
                      ),
                      Expanded(
                          child: Text("Số lượng")
                      ),
                      Expanded(
                          child: Text("")
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    children: widget.donHangModel.sanPhamDichVu!
                        .map((e) => TableRow(
                      children: [
                        TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(16.0),
                                color: Colors.white,
                                child: Text(
                                  '${e.tenSanPham}',
                                ))),
                        TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(16.0),
                                color: Colors.white,
                                child: Text(
                                  '${convertMoney(e.tongTien!)}',
                                ))),
                        TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(16.0),
                                color: Colors.white,
                                child: Text(
                                  '${e.soLuong!}',
                                ))),
                        TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                color: Colors.white,
                                child: isSelect(e.id!) || e.lichSuThaoTacResponse != null?
                                IconButton(
                                  icon: Icon(Icons.check_box, color: Colors.green,),
                                  onPressed: (){
                                    setState(() {
                                      try{
                                        widget.controller.showAlertDialog(context,widget.donHangModel.id!, e.id!);
                                      }catch(e){
                                        showSnackBarError("Error delete log", "ID log is null");
                                      }
                                    });
                                  },
                                ) :
                                IconButton(
                                  icon: Icon(Icons.check_box_outline_blank),
                                  onPressed: (){
                                    setState(() {
                                      try{
                                        changeCheck(e.id!, 0,e.idDonHangDichVu!, e.idSanPham!);
                                      }catch(e){
                                        showSnackBarError("Error save log", "ID sản phẩm is null");
                                      }
                                    });
                                  },
                                )
                            )
                        ),
                      ],
                    ))
                        .toList(),
                  ),
                  SizedBox(height: 50,)
                ],
              )
          ),
        ));
  }

}