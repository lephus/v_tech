import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/data/constants/constants.dart';
import 'package:v_tech/app/data/testing/MyFiles.dart';
import 'package:v_tech/app/modules/MyFile/RevenueModel.dart';
import 'package:v_tech/app/modules/MyFile/providers/my_file_provider.dart';
import 'package:intl/intl.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';


class MyFileController extends GetxController {
  final Random random = Random();
  Color color = Colors.red;
  final oCcy = new NumberFormat("#,###", "en_US");
  DateTime now = DateTime.now();
  var fromDate = "";
  var toDate = "";
  var onChange = false.obs;
  List<String> MenuDateTime = ["Hôm nay","Hôm qua", "Tuần này", "Thàng này"].obs;
  int selectDataTime = 0;
  List lstMyFiles = [];
  List<RevenueModel> revenueList = [];
  var isLoading = true.obs;
  var isLoadRevenue = true.obs;
  double sum = 0;
  List<PieChartSectionData> paiChartSelectionDatas = [];



  @override
  void onInit()async{
    chanDateTime();
    await getOverviewData();
    super.onInit();
  }

  @override
  void onReady()async{
    await GetRevenue();
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
    lstMyFiles.clear();
    paiChartSelectionDatas.clear();
    revenueList.clear();
    onChange.value = false;
  }

  @override
  void onClose() {
    lstMyFiles.clear();
    paiChartSelectionDatas.clear();
    revenueList.clear();
    onChange.value = false;
  }
  void chanDateTime(){
    if(selectDataTime == 0){
      fromDate = now.toString().split(' ')[0];
      toDate = new DateTime(now.year, now.month, now.day + 1).toString().split(' ')[0];
    }
    if(selectDataTime == 1){
      fromDate = new DateTime(now.year, now.month, now.day-2).toString().split(' ')[0];
      toDate =  new DateTime(now.year, now.month, now.day-1).toString().split(' ')[0];
    }
    if(selectDataTime == 2){
      DateTime f = getDate(now.subtract(Duration(days: now.weekday - 1)));
      DateTime t = getDate(now.add(Duration(days: DateTime.daysPerWeek - now.weekday)));
      fromDate = f.toString().split(' ')[0];
      toDate = t.toString().split(' ')[0];
    }
    if(selectDataTime == 3){
      fromDate =  new DateTime(now.year, now.month, 01).toString().split(' ')[0];
      toDate =  new DateTime(now.year, now.month+1, 01).toString().split(' ')[0];
    }
  }
  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  Future<void> getOverviewData()async {
    isLoading.value = true;
    lstMyFiles.clear();
    await MyFileProvider().getOverviewData(fromDate, toDate).then((resp){
      print(resp);
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        // DOANH THU
        var cloudStorageInfo1 = CloudStorageInfo(
            color: Colors.red,
            svgSrc: "assets/icons/Documents.svg",
            title: "Doanh thu",
            numOfFiles:  oCcy.format(resp.body['data']['doanhThuThoiGianTruoc']).toString(),
            percentage: resp.body['data']['phanTramDoanhThu'].toString(),
            totalStorage: oCcy.format(resp.body['data']['doanhThu']).toString()+ " VND",
        );
        lstMyFiles.add(cloudStorageInfo1);
        // TIỀN MẶT
        var cloudStorageInfo3 = CloudStorageInfo(
          color: Colors.blue,
          title: "Tiền mặt",
          svgSrc: "assets/icons/one_drive.svg",
          numOfFiles:  oCcy.format(resp.body['data']['tienMatThoiGianTruoc']).toString(),
          percentage: resp.body['data']['phanTramTienMat'].toString(),
          totalStorage: oCcy.format(resp.body['data']['tienMat']).toString()+ " VND",
        );
        lstMyFiles.add(cloudStorageInfo3);
        // TỒN KHO
        var cloudStorageInfo6 = CloudStorageInfo(
          color: Colors.deepOrangeAccent,
          title: "Tồn kho",
          svgSrc: "assets/icons/google_drive.svg",
          numOfFiles: resp.body['data']['tonKhoThoiGianTruoc'].toString(),
          percentage: resp.body['data']['phanTramTonKho'].toString(),
          totalStorage: resp.body['data']['tonKho'].toString(),
        );
        lstMyFiles.add(cloudStorageInfo6);
        // TRẢ HÀNG
        var cloudStorageInfo2 = CloudStorageInfo(
          color: Colors.red,
          title: "Trả hàng",
          svgSrc: "assets/icons/drop_box.svg",
          numOfFiles: resp.body['data']['traHangThoiGianTruoc'].toString(),
          percentage: resp.body['data']['phanTramTraHang'].toString(),
          totalStorage: resp.body['data']['traHang'].toString(),
        );
        lstMyFiles.add(cloudStorageInfo2);

        // TIỀN CHUYỂN KHOẢN
        var cloudStorageInfo4 = CloudStorageInfo(
          color: Colors.blue,
          title: "Tiền C.Khoản",
          svgSrc: "assets/icons/drop_box.svg",
          numOfFiles: oCcy.format(resp.body['data']['chuyenKhoanThoiGianTruoc']).toString(),
          percentage: resp.body['data']['phanTramChuyenKhoan'].toString(),
          totalStorage:  oCcy.format(resp.body['data']['chuyenKhoan']).toString()+" VND",
        );
        lstMyFiles.add(cloudStorageInfo4);
        // DANG CHUYEN KHO
        var cloudStorageInfo5 = CloudStorageInfo(
          color: Colors.deepOrangeAccent,
          title: "Đang c.Kho",
          svgSrc: "assets/icons/google_drive.svg",
          numOfFiles: resp.body['data']['dangChuyenKhoThoiGianTruoc'].toString(),
          percentage: resp.body['data']['phanTramDangChuyenKho'].toString(),
          totalStorage: resp.body['data']['dangChuyenKho'].toString(),
        );
        lstMyFiles.add(cloudStorageInfo5);
        // DANG VE
        var cloudStorageInfo8 = CloudStorageInfo(
          color: Colors.deepPurple,
          title: "Đang về",
          svgSrc: "assets/icons/google_drive.svg",
          numOfFiles: resp.body['data']['dangVeThoiGianTruoc'].toString(),
          percentage: resp.body['data']['phanTramDangVe'].toString(),
          totalStorage: resp.body['data']['dangVe'].toString(),
        );
        lstMyFiles.add(cloudStorageInfo8);
      // CONG NO
        var cloudStorageInfo7 = CloudStorageInfo(
          color: Colors.blueAccent,
          title: "Tồn kho",
          svgSrc: "assets/icons/google_drive.svg",
          numOfFiles: resp.body['data']['dangChuyenKhoThoiGianTruoc'].toString(),
          percentage: resp.body['data']['phanTramDangChuyenKho'].toString(),
          totalStorage: resp.body['data']['dangChuyenKho'].toString(),
        );
        lstMyFiles.add(cloudStorageInfo7);


        // KH MỚI
        var cloudStorageInfo9 = CloudStorageInfo(
          color: Colors.deepPurple,
          title: "KH mới",
          svgSrc: "assets/icons/drop_box.svg",
          numOfFiles: resp.body['data']['khachHangMoiThoiGianTruoc'].toString(),
          percentage: resp.body['data']['phanTramKhachHangMoi'].toString(),
          totalStorage: resp.body['data']['khachHangMoi'].toString(),
        );
        lstMyFiles.add(cloudStorageInfo9);
        isLoading.value = false;
      }else{
        showSnackBarError("Đã xảy ra lỗi", resp.body["message"]);
      }
    }).onError((error, stackTrace) => showSnackBarError("Đã Xảy Ra Lỗi", ErrorMessage));
  }

  Future<void> GetRevenue()async{
    isLoadRevenue.value = true;
    await MyFileProvider().GetRevenue(fromDate, toDate).then((resp){
      List tmp = resp.body["data"];
      revenueList.clear();
      sum=0;
      paiChartSelectionDatas.clear();
      for(int i =0 ; i< tmp.length; i++){
        RevenueModel re = new RevenueModel.fromJson(tmp[i]);
        revenueList.add(re);
        sum+=re.doanhThu!;
      }
      for(int i = 0; i< revenueList.length; i++){
        color = Color.fromARGB(
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
        );
        double p = ((sum / revenueList[i].doanhThu!)*100);
        paiChartSelectionDatas.add(new  PieChartSectionData(
          color: color,
          value: p,
          showTitle: false,
          radius: 25,
        ),);
      }
    });
    isLoadRevenue.value = false;
  }

}
