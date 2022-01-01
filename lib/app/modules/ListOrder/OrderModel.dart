import 'dart:convert';

DonHangModel donHangModelFromJson(String str) => DonHangModel.fromJson(json.decode(str));

String donHangModelToJson(DonHangModel data) => json.encode(data.toJson());

class DonHangModel {
    DonHangModel({
        this.id,
        this.idDoanhNghiep,
        this.idCuaHang,
        this.idKhachHang,
        this.idNhanVienBanHang,
        this.idDonHangBaoHanh,
        this.idNguonDonHang,
        this.ghiChuKhachHang,
        this.tienChuyenKhoan,
        this.tienMat,
        this.tienDatCoc,
        this.trangThai,
        this.tongTienHoaDon,
        this.noteCskh,
        this.sanPhamDichVu,
        this.sdtKhachHang,
        this.tenKhachHang,
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
        this.album,
        this.isChecked = false,
    });

    int? id;
    int? idDoanhNghiep;
    int? idCuaHang;
    int? idKhachHang;
    int? idNhanVienBanHang;
    dynamic idDonHangBaoHanh;
    dynamic idNguonDonHang;
    String? ghiChuKhachHang;
    double? tienChuyenKhoan;
    double? tienMat;
    dynamic tienDatCoc;
    String? trangThai;
    double? tongTienHoaDon;
    String? noteCskh;
    List<SanPhamDichVu>? sanPhamDichVu;
    String? sdtKhachHang;
    String? tenKhachHang;
    DateTime? createdDate;
    int? lastUpdatedBy;
    DateTime? lastUpdatedDate;
    dynamic createdBy;
    String? createdByName;
    String? lastUpdatedByName;
    CuaHangInfo? cuaHangInfo;
    dynamic ngayBaoKhach;
    dynamic ngayHenTraMay;
    dynamic trangThaiVanChuyen;
    List<dynamic>? album;
    bool? isChecked;

    factory DonHangModel.fromJson(Map<String, dynamic> json) => DonHangModel(
        id: json["id"],
        idDoanhNghiep: json["id_DoanhNghiep"],
        idCuaHang: json["id_CuaHang"],
        idKhachHang: json["id_KhachHang"],
        idNhanVienBanHang: json["id_NhanVienBanHang"],
        idDonHangBaoHanh: json["id_DonHangBaoHanh"],
        idNguonDonHang: json["idNguonDonHang"],
        ghiChuKhachHang: json["ghiChuKhachHang"],
        tienChuyenKhoan: json["tienChuyenKhoan"] ?? 0,
        tienMat: json["tienMat"] ?? 0,
        tienDatCoc: json["tienDatCoc"] ?? 0,
        trangThai: json["trangThai"] ?? "",
        tongTienHoaDon: json["tongTienHoaDon"] ?? 0,
        noteCskh: json["noteCSKH"],
        sanPhamDichVu: List<SanPhamDichVu>.from(json["sanPhamDichVu"].map((x) => SanPhamDichVu.fromJson(x))),
        sdtKhachHang: json["sdtKhachHang"],
        tenKhachHang: json["tenKhachHang"],
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
        album: List<dynamic>.from(json["album"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_DoanhNghiep": idDoanhNghiep,
        "id_CuaHang": idCuaHang,
        "id_KhachHang": idKhachHang,
        "id_NhanVienBanHang": idNhanVienBanHang,
        "id_DonHangBaoHanh": idDonHangBaoHanh,
        "idNguonDonHang": idNguonDonHang,
        "ghiChuKhachHang": ghiChuKhachHang,
        "tienChuyenKhoan": tienChuyenKhoan,
        "tienMat": tienMat,
        "tienDatCoc": tienDatCoc,
        "trangThai": trangThai,
        "tongTienHoaDon": tongTienHoaDon,
        "noteCSKH": noteCskh,
        "sanPhamDichVu": List<dynamic>.from(sanPhamDichVu!.map((x) => x.toJson())),
        "sdtKhachHang": sdtKhachHang,
        "tenKhachHang": tenKhachHang,
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
        "album": List<dynamic>.from(album!.map((x) => x)),
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

class SanPhamDichVu {
    SanPhamDichVu({
        this.id,
        this.idDonHangDichVu,
        this.idSanPham,
        this.idDichVu,
        this.soLuong,
        this.gia,
        this.loai,
        this.note,
        this.tongTien,
        this.loaiChietKhau,
        this.chietKhauSp,
        this.trangThai,
        this.tenSanPham,
        this.chiTietDichVu,
        this.type,
        this.fromBaoHanh,
        this.toBaoHanh,
        this.imei,
        this.lichSuThaoTacResponse,
    });

    int? id;
    int? idDonHangDichVu;
    int? idSanPham;
    String? idDichVu;
    int? soLuong;
    int? gia;
    dynamic loai;
    String? note;
    double? tongTien;
    dynamic loaiChietKhau;
    dynamic chietKhauSp;
    String? trangThai;
    String? tenSanPham;
    List<dynamic>? chiTietDichVu;
    String? type;
    dynamic fromBaoHanh;
    dynamic toBaoHanh;
    dynamic imei;
    dynamic lichSuThaoTacResponse;

    factory SanPhamDichVu.fromJson(Map<String, dynamic> json) => SanPhamDichVu(
        id: json["id"],
        idDonHangDichVu: json["id_DonHangDichVu"],
        idSanPham: json["id_SanPham"],
        idDichVu: json["id_DichVu"],
        soLuong: json["soLuong"],
        gia: json["gia"] ?? 0,
        loai: json["loai"],
        note: json["note"],
        tongTien: json["tongTien"] ?? 0,
        loaiChietKhau: json["loaiChietKhau"],
        chietKhauSp: json["chietKhauSP"],
        trangThai: json["trangThai"],
        tenSanPham: json["tenSanPham"],
        chiTietDichVu: List<dynamic>.from(json["chiTietDichVu"].map((x) => x)),
        type: json["type"],
        fromBaoHanh: json["fromBaoHanh"],
        toBaoHanh: json["toBaoHanh"],
        imei: json["imei"],
        lichSuThaoTacResponse: json["lichSuThaoTacResponse"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_DonHangDichVu": idDonHangDichVu,
        "id_SanPham": idSanPham,
        "id_DichVu": idDichVu,
        "soLuong": soLuong,
        "gia": gia,
        "loai": loai,
        "note": note,
        "tongTien": tongTien,
        "loaiChietKhau": loaiChietKhau,
        "chietKhauSP": chietKhauSp,
        "trangThai": trangThai,
        "tenSanPham": tenSanPham,
        "chiTietDichVu": List<dynamic>.from(chiTietDichVu!.map((x) => x)),
        "type": type,
        "fromBaoHanh": fromBaoHanh,
        "toBaoHanh": toBaoHanh,
        "imei": imei,
        "lichSuThaoTacResponse": lichSuThaoTacResponse,
    };
}
