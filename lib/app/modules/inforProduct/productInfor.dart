class ProductInfor {
  int? idDoanhNghiep;
  int? id;
  String? ten;
  String? tenKhac;
  String? ma;
  int? idSanPhamCha;
  String? maVach;
  String? videoGioiThieu;
  String? xuatXu;
  int? idTrangThai;
  int? idLoaiSanPham;
  String? anhSanPham;
  double? vat;
  String? donViSanPham;
  int? chieuDai;
  int? chieuRong;
  int? chieuCao;
  int? khoiLuong;
  int? coTheBan;
  String? diaChiBaoHanh;
  String? soDienThoai;
  int? soThangBaoHanh;
  String? noiDungBaoHanh;
  String? trangThai;
  String? loaiSanPham;
  String? createdDate;
  double? giaBan;
  double? giaBanKhachThan;
  double? giaBanTheoCuaHang;
  num? giaVon;
  int? tonKho;
  int? soLuongLoi;
  int? soLuongChuyenKho;
  int? soLuongDangGiao;
  String? tenSanPhamCha;
  List<SPDetailModel>? dsCuaHangTon;
  int count = 1;

  ProductInfor(
      {this.idDoanhNghiep,
        this.id,
        this.ten,
        this.tenKhac,
        this.ma,
        this.idSanPhamCha,
        this.maVach,
        this.videoGioiThieu,
        this.xuatXu,
        this.coTheBan,
        this.idTrangThai,
        this.idLoaiSanPham,
        this.anhSanPham,
        this.vat,
        this.donViSanPham,
        this.chieuDai,
        this.chieuRong,
        this.chieuCao,
        this.khoiLuong,
        this.diaChiBaoHanh,
        this.soDienThoai,
        this.soThangBaoHanh,
        this.noiDungBaoHanh,
        this.trangThai,
        this.loaiSanPham,
        this.createdDate,
        this.giaBan,
        this.giaVon,
        this.giaBanKhachThan,
        this.giaBanTheoCuaHang,
        this.soLuongLoi,
        this.soLuongChuyenKho,
        this.soLuongDangGiao,
        this.tenSanPhamCha,
        this.dsCuaHangTon,
        this.tonKho});

  factory ProductInfor.fromJson(Map<String, dynamic> json) {
    return ProductInfor(
        idDoanhNghiep: json['id_DoanhNghiep'],
        id: json['id'],
        ten: json['ten'],
        tenKhac: json['tenKhac'],
        coTheBan: json['coTheBan'],
        ma: json['ma'],
        idSanPhamCha: json['id_SanPhamCha'],
        maVach: json['maVach'],
        videoGioiThieu: json['videoGioiThieu'],
        xuatXu: json['xuatXu'],
        idTrangThai: json['id_TrangThai'],
        idLoaiSanPham: json['id_LoaiSanPham'],
        anhSanPham: json['anhSanPham'],
        vat: json['vat'],
        donViSanPham: json['donViSanPham'],
        chieuDai: json['chieuDai'],
        chieuRong: json['chieuRong'],
        chieuCao: json['chieuCao'],
        khoiLuong: json['khoiLuong'],
        diaChiBaoHanh: json['diaChiBaoHanh'],
        soDienThoai: json['soDienThoai'],
        soThangBaoHanh: json['soThangBaoHanh'],
        noiDungBaoHanh: json['noiDungBaoHanh'],
        trangThai: json['trangThai'],
        loaiSanPham: json['loaiSanPham'],
        createdDate: json['createdDate'],
        giaBan: json['giaBan'],
        giaBanKhachThan: json['giaBanKhachThan'] == null ? 0.0 : json['giaBanKhachThan'],
        giaBanTheoCuaHang: json['giaBanTheoCuaHang'] == null ? 0.0 : double.parse(json['giaBanTheoCuaHang'].toString()),
        giaVon: json['giaVon'] == null ? 0.0 : json['giaVon'],
        soLuongLoi: json['soLuongLoi'],
        soLuongChuyenKho: json['soLuongChuyenKho'],
        soLuongDangGiao: json['soLuongDangGiao'],
        tenSanPhamCha: json['tenSanPhamCha'],
        dsCuaHangTon: List<SPDetailModel>.from(
            json['danhSachCuaHangTon'].map((x) => SPDetailModel.fromJson(x))),
        tonKho: json['tonKho']);
  }
}
class SPDetailModel {
  int? id;
  String? diaChi;
  String? ten;
  String? dienThoai;
  int? tong;
  int? ton;
  int? dangVe;
  int? chuyenKho;
  int? loiKhongBanDuoc;

  SPDetailModel(
      { this.id,
        this.ten,
        this.diaChi,
        this.dienThoai,
        this.tong,
        this.ton,
        this.dangVe,
        this.chuyenKho,
        this.loiKhongBanDuoc});

  factory SPDetailModel.fromJson(Map<String, dynamic> json) {
    return SPDetailModel(
        id: json['id'],
        ten: json['ten'],
        diaChi: json['diaChi'],
        dienThoai: json['dienThoai'],
        tong: json['tong'] ?? 0,
        ton: json['soLuong'],
        chuyenKho: json['chuyenKho'] ?? 0,
        dangVe: json['dangVe'] ?? 0,
        loiKhongBanDuoc: json['loiKhongBanDuoc']);
  }
}
class DanhSachCuaHangTon {
  DanhSachCuaHangTon({
    required this.idSanPham,
    required this.id,
    this.ten,
    this.diaChi,
    this.dienThoai,
    required this.soLuong,
    required this.loiKhongBanDuoc,
  });

  int idSanPham;
  int id;
  dynamic ten;
  dynamic diaChi;
  dynamic dienThoai;
  int soLuong;
  int loiKhongBanDuoc;

  factory DanhSachCuaHangTon.fromJson(Map<String, dynamic> json) => DanhSachCuaHangTon(
    idSanPham: json["id_SanPham"],
    id: json["id"],
    ten: json["ten"],
    diaChi: json["diaChi"],
    dienThoai: json["dienThoai"],
    soLuong: json["soLuong"],
    loiKhongBanDuoc: json["loiKhongBanDuoc"],
  );

  Map<String, dynamic> toJson() => {
    "id_SanPham": idSanPham,
    "id": id,
    "ten": ten,
    "diaChi": diaChi,
    "dienThoai": dienThoai,
    "soLuong": soLuong,
    "loiKhongBanDuoc": loiKhongBanDuoc,
  };
}
class LoModel {
  int? idDoanhNghiep;
  int? id;
  String? soLo;
  int? idSanPham;
  double? giaNhap;
  String? ngaySanXuat;
  String? ngayHethan;
  String? createdDate;

  LoModel(
      {this.idDoanhNghiep,
        this.id,
        this.soLo,
        this.idSanPham,
        this.giaNhap,
        this.ngaySanXuat,
        this.ngayHethan,
        this.createdDate});

  LoModel.fromJson(Map<String, dynamic> json) {
    idDoanhNghiep = json['id_DoanhNghiep'];
    id = json['id'];
    soLo = json['soLo'];
    idSanPham = json['id_SanPham'];
    giaNhap = json['giaNhap'];
    ngaySanXuat = json['ngaySanXuat'];
    ngayHethan = json['ngayHethan'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_DoanhNghiep'] = this.idDoanhNghiep;
    data['id'] = this.id;
    data['soLo'] = this.soLo;
    data['id_SanPham'] = this.idSanPham;
    data['giaNhap'] = this.giaNhap;
    data['ngaySanXuat'] = this.ngaySanXuat;
    data['ngayHethan'] = this.ngayHethan;
    data['createdDate'] = this.createdDate;
    return data;
  }
}