import 'package:get/get.dart';
import 'package:v_tech/app/modules/permissions/PermissionsModel.dart';
import 'package:v_tech/app/modules/permissions/providers/permissions_provider.dart';

class PermissionsController extends GetxController {
  // DAT HANG [NO]
  var DAT_HANG = "DatHang"; // dat hang
  var DAT_HANG_SUB = "DatHang";
  // SAN PHAM [XEM]
  var SAN_PHAM = "SanPham";
  var SAN_PHAM_SUB = "SanPham";
  // KHO HANG
  var KHO_HANG = "KhoHang";
  var CHUYEN_KHO = "ChuyenKho";
  var CHUYEN_KHO_CREATE = "ChuyenKho.Create";
  var CHUYEN_KHO_DELETE = "ChuyenKho.Delete";
  var PHIEU_DAT_HANG  = "PhieuDatHang";
  var PHIEU_DAT_HANG_CREATE = "PhieuDatHang.Create";
  var PHIEU_DAT_HANG_DELETE = "PhieuDatHang.Delete";

  // KHO
  var PHIEU_XNK = "PhieuXNK";
  var CHUYEN_KHO_ = "ChuyenKho";
  var HANG_DANG_VE = "PhieuDatHang";
  // BAN HANG
  var BAN_HANG = "BanHang";
  var HOA_DON = "HoaDon";
  var HOA_DON_UPDATE_STATUS = "HoaDon.UpdateStatus";
  var HOA_DON_VIEW_HISTORY = "HoaDon.GetHistoryDonHangDichVu";
  // HANH CHINH - DON HANG LAP RAP
  var HANH_CHINH = "HanhChinh";
  var DON_HANG_LAP_RAP = "DonHangLapRap";
  var DON_HANG_LAP_RAP_CREATE_UPDATE = "DonHangLapRap.Save";
  var DON_HANG_LAP_RAP_DELETE = "DonHangLapRap.Delete";
  var KHACH_HANG = "KhachHang";
  var LICH_SU_VAN_DON = "LichSuVanDon";
  var PHIEU_SUA_CHUA = "PhieuSuaChua";


  var isLoadPermissions = true;
  var doneLoadPermissions = false;
  static List<PermissionsModel> permissionsModels = [];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> GetPermissionsByID(var id, String token)async{
    isLoadPermissions = true; doneLoadPermissions = false;
    await PermissionsProvider().GetPermissionsByID(id, token).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        isLoadPermissions = false; doneLoadPermissions = true;
        var data = resp.body['data'];
        List tmp = [];
        tmp = data['listPermissions'];
        permissionsModels.clear();
        for(int i = 0; i<tmp.length; i++){
          permissionsModels.add(new PermissionsModel.fromJson(tmp[i]));
        }
      }else{
        isLoadPermissions = false; doneLoadPermissions = false;
      }
      print(permissionsModels.length);
    }).onError((error, stackTrace){isLoadPermissions = false; doneLoadPermissions = false;});
  }

  bool CheckPermissionFunction(var key){
    for(int i = 0; i < permissionsModels.length; i++ ){
      if(permissionsModels[i].ten == key){
        return permissionsModels[i].checked ?? false;
      }else{
        List<PermissionsModel> listPermissionsTemp = permissionsModels[i].children ?? [];
        for(int j = 0; j<listPermissionsTemp.length; j++){
          if(listPermissionsTemp[j].ten == key){
            return listPermissionsTemp[j].checked ?? false;
          }else{
            List<PermissionsModel> listPermissionsTemp2 = listPermissionsTemp[j].children ?? [];
            for(int k = 0; k<listPermissionsTemp2.length; k++){
              if(listPermissionsTemp2[k].ten == key){
                return listPermissionsTemp2[k].checked ?? false;
              }
            }
          }
        }
      }
    }
    return false;
  }
}
