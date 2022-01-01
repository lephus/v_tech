import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';

import '../controllers/infor_product_controller.dart';

class InformationProduct extends GetView<InforProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400],
        body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Obx(()=>
              controller.isLoadingInformation.value ?
                  Center(child: CircularProgressIndicator(),) :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 12.0,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: VerticalTextCell(
                              displayDivider: true,
                              title: 'tồn',
                              content:  '${controller.Product!.tonKho ?? 0}',
                            ),
                          ),
                          Expanded(
                            child: VerticalTextCell(
                              displayDivider: true,
                              title: 'đang giao',
                              content: '${controller.Product!.soLuongDangGiao ?? 0}',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: VerticalTextCell(
                              displayDivider: true,
                              title: 'chuyển kho',
                              content: '${controller.Product!.soLuongChuyenKho ?? 0}',
                            ),
                          ),
                        ],
                      ),
                      _buildSanPham(context),
                ],
              )
              ),
            )));
  }

  Widget _buildSanPham(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 16.0),
        VerticalTextCell(
          displayDivider: true,
          title: 'Tên sản phẩm',
          content: '${controller.Product!.ten}',
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: VerticalTextCell(
                displayDivider: true,
                title: 'Mã sản phẩm',
                content: '${controller.Product!.ma ?? ''}',
              ),
            ),
            Expanded(
              child: VerticalTextCell(
                displayDivider: true,
                title: 'Mã vạch',
                content: '${controller.Product!.maVach ?? ''}',
              ),
            ),
          ],
        ),
        HorizontalTextCell(
          isUpperFirst: true,
          switchColor: true,
          title: 'sản phẩm cha',
          content: '${controller.Product!.tenSanPhamCha ?? ''}',
        ),
        HorizontalTextCell(
          isUpperFirst: true,
          switchColor: true,
          title: 'Giá bán lẻ',
          content: '${convertMoney(double.parse(controller.Product!.giaBan.toString()))}',
        ),
        HorizontalTextCell(
          isUpperFirst: true,
          switchColor: true,
          title: 'Giá bán khách thân',
          content: '${convertMoney(double.parse(controller.Product!.giaBanKhachThan.toString()))}',
        ),
        HorizontalTextCell(
          isUpperFirst: true,
          switchColor: true,
          title: 'Giá bán theo cửa hàng',
          content: '${convertMoney(double.parse(controller.Product!.giaBanTheoCuaHang.toString()))}',
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: VerticalTextCell(
                displayDivider: true,
                title: 'Giá nhập',
                content: '0 VND',
              ),
            ),
            Expanded(
              child: VerticalTextCell(
                displayDivider: true,
                title: 'VAT',
                content: '',
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget _buildLoArea(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.only(bottom: 8.0, top: 16.0, left: 8.0),
  //         child: Text('Lô sản phẩm', style: TextStyle(fontSize: 16.0)),
  //       ),
  //       Table(
  //         border: TableBorder.all(
  //           width: 1.0,
  //           color: Colors.grey,
  //         ),
  //         children: [
  //           TableRow(children: [
  //             TableCell(
  //                 child: Container(
  //                     alignment: Alignment.center,
  //                     padding: const EdgeInsets.all(16.0),
  //                     color: Colors.grey[300],
  //                     child: Text('Số lô',
  //                         style: CommonStyle.strongTextBlack(context)))),
  //             TableCell(
  //                 child: Container(
  //                     alignment: Alignment.center,
  //                     padding: const EdgeInsets.all(16.0),
  //                     color: Colors.grey[300],
  //                     child: Text(
  //                       'Giá tiền',
  //                       style: CommonStyle.strongTextBlack(context),
  //                     ))),
  //           ]),
  //         ],
  //       ),
  //       Table(
  //         border: TableBorder.all(
  //           width: 1.0,
  //           color: Colors.grey,
  //         ),
  //         children: controller.loList
  //             .map((e) => TableRow(
  //           children: [
  //             TableCell(
  //                 child: Container(
  //                     alignment: Alignment.center,
  //                     padding: const EdgeInsets.all(16.0),
  //                     color: Colors.white,
  //                     child: Text(
  //                       '${e.soLo}',
  //                     ))),
  //             TableCell(
  //                 child: Container(
  //                     alignment: Alignment.center,
  //                     padding: const EdgeInsets.all(16.0),
  //                     color: Colors.white,
  //                     child: Text(
  //                       '{convertMoney(e.giaNhap)}',
  //                     ))),
  //           ],
  //         ))
  //             .toList(),
  //       )
  //     ],
  //   );
  // }
  //
  // Widget _buildNangCao(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.only(bottom: 8.0, top: 16.0, left: 8.0),
  //         child: Text('Nâng cao', style: TextStyle(fontSize: 16.0)),
  //       ),
  //       HorizontalTextCell(
  //         isUpperFirst: true,
  //         switchColor: true,
  //         title: 'Loại sản phẩm',
  //         content: '${controller.Product!.loaiSanPham}',
  //       ),
  //       HorizontalTextCell(
  //         isUpperFirst: true,
  //         switchColor: true,
  //         title: 'Trạng thái',
  //         content: '${controller.Product!.trangThai ?? ''}',
  //       ),
  //       HorizontalTextCell(
  //           isUpperFirst: true,
  //           switchColor: true,
  //           title: 'Xuất xứ',
  //           content: '${controller.Product!.xuatXu ?? ''}'
  //       ),
  //       HorizontalTextCell(
  //         isUpperFirst: true,
  //         switchColor: true,
  //         title: 'Thương hiệu',
  //         content: '',
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildKichThuoc(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.only(bottom: 8.0, top: 16.0, left: 8.0),
  //         child: Text('Kích thước', style: TextStyle(fontSize: 16.0)),
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: VerticalTextCell(
  //               displayDivider: true,
  //               title: 'Đơn vị sản phẩm',
  //               content: '${controller.Product!.donViSanPham}',
  //             ),
  //           ),
  //           Expanded(
  //               child: VerticalTextCellUnit(
  //                 title: 'Khối lượng cả hộp',
  //                 content: '${controller.Product!.khoiLuong ?? '??'}',
  //                 unit: 'gram',
  //               ))
  //         ],
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: VerticalTextCellUnit(
  //               title: 'Chiều dài',
  //               content: '${controller.Product!.chieuDai ?? '??'}',
  //               unit: 'cm',
  //             ),
  //           ),
  //           Expanded(
  //             child: VerticalTextCellUnit(
  //               title: 'Chiều rộng',
  //               content: '${controller.Product!.chieuRong ?? '??'}',
  //               unit: 'cm',
  //             ),
  //           ),
  //           Expanded(
  //             child: VerticalTextCellUnit(
  //               title: 'Chiều cao',
  //               content: '${controller.Product!.chieuCao ?? '??'}',
  //               unit: 'cm',
  //             ),
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }
  //
  // Widget _buildBaoHanh(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.only(bottom: 8.0, top: 16.0, left: 8.0),
  //         child: Text('Bảo hành', style: TextStyle(fontSize: 16.0)),
  //       ),
  //       HorizontalTextCell(
  //         switchColor: true,
  //         title: 'Địa chỉ bảo hành',
  //         content: '${controller.Product!.diaChiBaoHanh ?? ''}',
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: VerticalTextCell(
  //               displayDivider: true,
  //               title: 'Số điện thoại',
  //               content: '${controller.Product!.soDienThoai ?? ''}',
  //             ),
  //           ),
  //           Expanded(
  //             child: VerticalTextCell(
  //               displayDivider: true,
  //               title: 'Số tháng bảo hành',
  //               content: '${controller.Product!.soThangBaoHanh ?? 0}',
  //             ),
  //           )
  //         ],
  //       ),
  //     ],
  //   );
  // }
}