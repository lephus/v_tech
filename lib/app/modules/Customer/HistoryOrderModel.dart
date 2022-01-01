
import 'dart:convert';

HistoryOrderModel historyOrderModelFromJson(String str) => HistoryOrderModel.fromJson(json.decode(str));

String historyOrderModelToJson(HistoryOrderModel data) => json.encode(data.toJson());

class HistoryOrderModel {
  HistoryOrderModel({
    this.id,
    this.idDoanhNghiep,
    this.idCuaHang,
    this.idKhachHang,
    this.idNhanVienBanHang,
    this.idDonHangBaoHanh,
    this.ghiChuKhachHang,
    this.tienChuyenKhoan,
    this.tienMat,
    this.tienDatCoc,
    this.trangThai,
    this.tongTienHoaDon,
    this.noteCskh,
    this.tenNhanVienBanHang,
    this.sanPhamDichVu,
    this.chiTiet,
    this.butToan,
    this.khachHang,
    this.createdDate,
    this.lastUpdatedBy,
    this.lastUpdatedDate,
    this.createdBy,
    this.createdByName,
    this.lastUpdatedByName,
    this.cuaHangInfo,
    this.ngayBaoKhach,
    this.ngayHenTraMay,
    this.trangThaiVanChuyen,
    this.loiNhuan,
    this.congNo,
    this.album,
    this.lichSuUpdate,
  });

  int? id;
  int? idDoanhNghiep;
  int? idCuaHang;
  int? idKhachHang;
  int? idNhanVienBanHang;
  int? idDonHangBaoHanh;
  String? ghiChuKhachHang;
  double? tienChuyenKhoan;
  double? tienMat;
  dynamic tienDatCoc;
  String? trangThai;
  double? tongTienHoaDon;
  String? noteCskh;
  dynamic tenNhanVienBanHang;
  List<dynamic>? sanPhamDichVu;
  List<ChiTiet>? chiTiet;
  List<dynamic>? butToan;
  KhachHang? khachHang;
  DateTime? createdDate;
  int? lastUpdatedBy;
  DateTime? lastUpdatedDate;
  int? createdBy;
  dynamic createdByName;
  dynamic lastUpdatedByName;
  CuaHangInfo? cuaHangInfo;
  dynamic ngayBaoKhach;
  dynamic ngayHenTraMay;
  String? trangThaiVanChuyen;
  dynamic loiNhuan;
  dynamic congNo;
  dynamic album;
  dynamic lichSuUpdate;

  factory HistoryOrderModel.fromJson(Map<String, dynamic> json) => HistoryOrderModel(
    id: json["id"],
    idDoanhNghiep: json["id_DoanhNghiep"],
    idCuaHang: json["id_CuaHang"],
    idKhachHang: json["id_KhachHang"],
    idNhanVienBanHang: json["id_NhanVienBanHang"],
    idDonHangBaoHanh: json["id_DonHangBaoHanh"],
    ghiChuKhachHang: json["ghiChuKhachHang"],
    tienChuyenKhoan: json["tienChuyenKhoan"],
    tienMat: json["tienMat"],
    tienDatCoc: json["tienDatCoc"],
    trangThai: json["trangThai"],
    tongTienHoaDon: json["tongTienHoaDon"],
    noteCskh: json["noteCSKH"],
    tenNhanVienBanHang: json["tenNhanVienBanHang"],
    sanPhamDichVu: List<dynamic>.from(json["sanPhamDichVu"].map((x) => x)),
    chiTiet: List<ChiTiet>.from(json["chiTiet"].map((x) => ChiTiet.fromJson(x))),
    butToan: List<dynamic>.from(json["butToan"].map((x) => x)),
    khachHang: KhachHang.fromJson(json["khachHang"]),
    createdDate: DateTime.parse(json["createdDate"]),
    lastUpdatedBy: json["lastUpdatedBy"],
    lastUpdatedDate: DateTime.parse(json["lastUpdatedDate"]),
    createdBy: json["createdBy"],
    createdByName: json["createdByName"],
    lastUpdatedByName: json["lastUpdatedByName"],
    cuaHangInfo: CuaHangInfo.fromJson(json["cuaHangInfo"]),
    ngayBaoKhach: json["ngayBaoKhach"],
    ngayHenTraMay: json["ngayHenTraMay"],
    trangThaiVanChuyen: json["trangThaiVanChuyen"],
    loiNhuan: json["loiNhuan"],
    congNo: json["congNo"],
    album: json["album"],
    lichSuUpdate: json["lichSuUpdate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_DoanhNghiep": idDoanhNghiep,
    "id_CuaHang": idCuaHang,
    "id_KhachHang": idKhachHang,
    "id_NhanVienBanHang": idNhanVienBanHang,
    "id_DonHangBaoHanh": idDonHangBaoHanh,
    "ghiChuKhachHang": ghiChuKhachHang,
    "tienChuyenKhoan": tienChuyenKhoan,
    "tienMat": tienMat,
    "tienDatCoc": tienDatCoc,
    "trangThai": trangThai,
    "tongTienHoaDon": tongTienHoaDon,
    "noteCSKH": noteCskh,
    "tenNhanVienBanHang": tenNhanVienBanHang,
    "sanPhamDichVu": List<dynamic>.from(sanPhamDichVu!.map((x) => x)),
    "chiTiet": List<dynamic>.from(chiTiet!.map((x) => x.toJson())),
    "butToan": List<dynamic>.from(butToan!.map((x) => x)),
    "khachHang": khachHang!.toJson(),
    "createdDate": createdDate.toString(),
    "lastUpdatedBy": lastUpdatedBy,
    "lastUpdatedDate": lastUpdatedDate.toString(),
    "createdBy": createdBy,
    "createdByName": createdByName,
    "lastUpdatedByName": lastUpdatedByName,
    "cuaHangInfo": cuaHangInfo!.toJson(),
    "ngayBaoKhach": ngayBaoKhach,
    "ngayHenTraMay": ngayHenTraMay,
    "trangThaiVanChuyen": trangThaiVanChuyen,
    "loiNhuan": loiNhuan,
    "congNo": congNo,
    "album": album,
    "lichSuUpdate": lichSuUpdate,
  };
}

class ChiTiet {
  ChiTiet({
    this.id,
    this.idHoaDon,
    this.idSanPham,
    this.tenSanPham,
    this.maSanPham,
    this.soLuong,
    this.gia,
    this.loai,
    this.note,
    this.tongTien,
    this.album,
    this.createdDate,
    this.loaiChietKhau,
    this.chietKhauSp,
    this.idLoaiSanPham,
    this.tenLoaiSanPham,
  });

  int? id;
  int? idHoaDon;
  int? idSanPham;
  String ?tenSanPham;
  String? maSanPham;
  int? soLuong;
  double? gia;
  String? loai;
  String? note;
  double? tongTien;
  List<dynamic>? album;
  DateTime? createdDate;
  dynamic loaiChietKhau;
  dynamic chietKhauSp;
  int? idLoaiSanPham;
  dynamic tenLoaiSanPham;

  factory ChiTiet.fromJson(Map<String, dynamic> json) => ChiTiet(
    id: json["id"],
    idHoaDon: json["id_HoaDon"],
    idSanPham: json["id_SanPham"],
    tenSanPham: json["tenSanPham"],
    maSanPham: json["maSanPham"],
    soLuong: json["soLuong"],
    gia: double.parse(json["gia"].toString()),
    loai: json["loai"],
    note: json["note"],
    tongTien: json["tongTien"],
    album: List<dynamic>.from(json["album"].map((x) => x)),
    createdDate: DateTime.parse(json["createdDate"]),
    loaiChietKhau: json["loaiChietKhau"],
    chietKhauSp: json["chietKhauSP"],
    idLoaiSanPham: json["id_LoaiSanPham"],
    tenLoaiSanPham: json["ten_LoaiSanPham"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_HoaDon": idHoaDon,
    "id_SanPham": idSanPham,
    "tenSanPham": tenSanPham,
    "maSanPham": maSanPham,
    "soLuong": soLuong,
    "gia": gia,
    "loai": loai,
    "note": note,
    "tongTien": tongTien,
    "album": List<dynamic>.from(album!.map((x) => x)),
    "createdDate": createdDate.toString(),
    "loaiChietKhau": loaiChietKhau,
    "chietKhauSP": chietKhauSp,
    "id_LoaiSanPham": idLoaiSanPham,
    "ten_LoaiSanPham": tenLoaiSanPham,
  };
}

class CuaHangInfo {
  CuaHangInfo({
    this.idDoanhNghiep,
    this.id,
    this.ten,
    this.diaChi,
    this.dienThoai,
    this.soTaiKhoan,
    this.tenNganHang,
    this.chiNhanh,
  });

  int? idDoanhNghiep;
  int? id;
  String? ten;
  String? diaChi;
  dynamic dienThoai;
  dynamic soTaiKhoan;
  dynamic tenNganHang;
  dynamic chiNhanh;

  factory CuaHangInfo.fromJson(Map<String, dynamic> json) => CuaHangInfo(
    idDoanhNghiep: json["id_DoanhNghiep"],
    id: json["id"],
    ten: json["ten"],
    diaChi: json["diaChi"],
    dienThoai: json["dienThoai"],
    soTaiKhoan: json["soTaiKhoan"],
    tenNganHang: json["tenNganHang"],
    chiNhanh: json["chiNhanh"],
  );

  Map<String, dynamic> toJson() => {
    "id_DoanhNghiep": idDoanhNghiep,
    "id": id,
    "ten": ten,
    "diaChi": diaChi,
    "dienThoai": dienThoai,
    "soTaiKhoan": soTaiKhoan,
    "tenNganHang": tenNganHang,
    "chiNhanh": chiNhanh,
  };
}

class KhachHang {
  KhachHang({
    this.id,
    this.tenDayDu,
    this.soDienThoai,
    this.email,
    this.facebook,
    this.ngaySinh,
    this.gioiTinh,
    this.diaChi,
    this.thanhPho,
    this.quanHuyen,
    this.phuongXa,
    this.idTinh,
    this.idHuyen,
    this.idXa,
    this.idLoaiKhachHang,
    this.tenLoaiKhachHang,
    this.congTy,
    this.maSoThue,
    this.chungMinhNhanDan,
    this.ghiChu,
    this.idNhanVienPhuTrach,
    this.anhDaiDien,
    this.tongTien,
    this.soLanMua,
    this.soLuongSanPhamMua,
    this.diem,
    this.idKhachHangGioiThieu,
    this.congNo,
    this.gioiHanCongNo,
    this.daTieu,
    this.daTra,
    this.conNo,
    this.qHKhachHangThe,
    this.selectHuyenList,
    this.selectXaList,
  });

  int? id;
  String? tenDayDu;
  String? soDienThoai;
  String? email;
  String? facebook;
  DateTime? ngaySinh;
  String? gioiTinh;
  String? diaChi;
  String? thanhPho;
  String? quanHuyen;
  String? phuongXa;
  int? idTinh;
  int? idHuyen;
  int? idXa;
  int? idLoaiKhachHang;
  dynamic tenLoaiKhachHang;
  String? congTy;
  String? maSoThue;
  String? chungMinhNhanDan;
  String? ghiChu;
  int? idNhanVienPhuTrach;
  dynamic anhDaiDien;
  dynamic tongTien;
  dynamic soLanMua;
  dynamic soLuongSanPhamMua;
  dynamic diem;
  int? idKhachHangGioiThieu;
  dynamic congNo;
  double? gioiHanCongNo;
  dynamic daTieu;
  dynamic daTra;
  dynamic conNo;
  dynamic qHKhachHangThe;
  dynamic selectHuyenList;
  dynamic selectXaList;

  factory KhachHang.fromJson(Map<String, dynamic> json) => KhachHang(
    id: json["id"],
    tenDayDu: json["tenDayDu"],
    soDienThoai: json["soDienThoai"],
    email: json["email"],
    facebook: json["facebook"],
    ngaySinh: json["ngaySinh"] == null ? null : DateTime.parse(json["ngaySinh"]),
    gioiTinh: json["gioiTinh"],
    diaChi: json["diaChi"],
    thanhPho: json["thanhPho"],
    quanHuyen: json["quanHuyen"],
    phuongXa: json["phuongXa"],
    idTinh: json["idTinh"],
    idHuyen: json["idHuyen"],
    idXa: json["idXa"],
    idLoaiKhachHang: json["id_LoaiKhachHang"],
    tenLoaiKhachHang: json["ten_LoaiKhachHang"],
    congTy: json["congTy"],
    maSoThue: json["maSoThue"],
    chungMinhNhanDan: json["chungMinhNhanDan"],
    ghiChu: json["ghiChu"],
    idNhanVienPhuTrach: json["id_NhanVienPhuTrach"],
    anhDaiDien: json["anhDaiDien"],
    tongTien: json["tongTien"],
    soLanMua: json["soLanMua"],
    soLuongSanPhamMua: json["soLuongSanPhamMua"],
    diem: json["diem"],
    idKhachHangGioiThieu: json["id_KhachHangGioiThieu"],
    congNo: json["congNo"],
    gioiHanCongNo: json["gioiHanCongNo"],
    daTieu: json["daTieu"],
    daTra: json["daTra"],
    conNo: json["conNo"],
    qHKhachHangThe: json["qH_KhachHang_The"],
    selectHuyenList: json["selectHuyenList"],
    selectXaList: json["selectXaList"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tenDayDu": tenDayDu,
    "soDienThoai": soDienThoai,
    "email": email,
    "facebook": facebook,
    "ngaySinh": ngaySinh.toString(),
    "gioiTinh": gioiTinh,
    "diaChi": diaChi,
    "thanhPho": thanhPho,
    "quanHuyen": quanHuyen,
    "phuongXa": phuongXa,
    "idTinh": idTinh,
    "idHuyen": idHuyen,
    "idXa": idXa,
    "id_LoaiKhachHang": idLoaiKhachHang,
    "ten_LoaiKhachHang": tenLoaiKhachHang,
    "congTy": congTy,
    "maSoThue": maSoThue,
    "chungMinhNhanDan": chungMinhNhanDan,
    "ghiChu": ghiChu,
    "id_NhanVienPhuTrach": idNhanVienPhuTrach,
    "anhDaiDien": anhDaiDien,
    "tongTien": tongTien,
    "soLanMua": soLanMua,
    "soLuongSanPhamMua": soLuongSanPhamMua,
    "diem": diem,
    "id_KhachHangGioiThieu": idKhachHangGioiThieu,
    "congNo": congNo,
    "gioiHanCongNo": gioiHanCongNo,
    "daTieu": daTieu,
    "daTra": daTra,
    "conNo": conNo,
    "qH_KhachHang_The": qHKhachHangThe,
    "selectHuyenList": selectHuyenList,
    "selectXaList": selectXaList,
  };
}
