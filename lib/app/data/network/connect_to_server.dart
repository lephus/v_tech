class ConnectToServer{
  static String BaseUrl = 'http://103.124.95.142:8181/';
  static String GetPermissions = 'api/HanhDong/GetByUserId?userId=';
  static String PostTokenApi = 'api/FCM/add-token';
  static String RemoveTokenFireBase = 'api/FCM/remove-token';
  static String LoginURL = 'api/User/authenticate';
  static String autoLoginURL = 'api/User/activation';
  static String RegisterURL = 'api/User/register';
  static String ValidateOTP = 'api/User/validate-otp';
  static String GetDataDashboard = 'api/Dashboard/get-data-dashboard';
  static String GetListTypeProduct = 'api/Master/danh-sach-loai-san-pham';
  static String GetDataTableProduct = 'api/SanPham/search';
  static String GetProduct = 'api/SanPham/search-v2';
  static String GetProductByID = 'api/SanPham/get-by-id?id=';
  static String GetOverviewData = 'api/Dashboard/get-tong-quan-du-lieu';
  static String GetRevenueByStore = 'api/Dashboard/get-revenue-by-store';
  static String GetRevenue = 'api/Dashboard/get-doanh-thu-cua-hang';
  static String GetListStore = 'api/CuaHang/search';
  static String GetListOrder = 'api/DonHangDichVu/search-don-hang-dich-vu';
  static String GetListStatusType = 'api/TrangThaiHopDongDichVu/get-status-by-type?type=DICH_VU';
  static String UpdateStatusOrder = 'api/DonHangDichVu/update-trang-thai-don-hang';
  static String UploadImage = 'api/DonHangDichVu/upload-attachment';
  static String GetListCustomer = 'api/KhachHang/danh-sach-khach-hang';
  static String GetDetailOrder = 'api/KhachHang/lich_su_mua_hang';
  static String GetTransfer = 'api/YeuCauChuyenKho/search';
  static String ConfirmTransfer = 'api/YeuCauChuyenKho/xac-nhan?id=';
  static String AccessTransfer = 'api/YeuCauChuyenKho/duyet?id=';
  static String GetDetailTransfer = 'api/YeuCauChuyenKho/get-by-id?id=';
  static String GetProductAreComing = 'api/YeuCauXNK/san-pham-phieu-dat-hang';
  static String GetNhaCungCap = 'api/NhaCungCap/search?s=1&pageIndex=1&pageSize=100000';
  static String GetBillOrder = 'api/YeuCauXNK/search';
  static String PostImageTransfer = 'api/YeuCauChuyenKho/upload-attachment';
  static String GetProfile = 'api/User/my-profile';
  static String UpdateProfile = 'api/User/update';
  static String UpdatePassword = 'api/User/change-pass';
  static String GetOrderAssemble = 'api/don-hang-lap-rap/get-all';
  static String SystemNotify = 'api/system-notification/get-some-displayed';
  static String GetLapRap = 'api/lap-rap/get-all';
  static String AddOrderAssemble = 'api/don-hang-lap-rap/save';
  static String DeleteOrderAssemble = 'api/don-hang-lap-rap/delete';
  static String GetDetailOrderAssemble = 'api/don-hang-lap-rap/get?id=';
  static String GetDataImportAndExportProduct = 'api/ThucThiXNK/san-pham-xuat-nhap-kho';
  static String GetDetailDetailBillOrder = 'api/YeuCauXNK/get-by-id?id=';
  static String GetImageDetailBillOrder = 'api/YeuCauXNK/get-anh-theo-idxnk/';
  static String PostImageDetailBillOrder = 'api/YeuCauXNK/upload-attachment?idPhieu=';
  static String GetBillOfLadingHistory = 'api/lich-su-van-don/search';
  static String EditBillOfLadingHistory = 'api/lich-su-van-don/save';
  static String DeleteBillOfLadingHistory = 'api/lich-su-van-don/delete/';
  static String GetRepair = 'api/PhieuSuaChua/search-phieu-sua-chua';
  static String GetCustomer = 'api/KhachHang/danh-sach-khach-hang';
  static String GetDetailBillRepair = 'api/PhieuSuaChua/get-phieu-by-id?Id_Phieu=';
  static String GetListDetailRepair = 'api/PhieuSuaChua/get-danh-sach-chi-tiet';
  static String UpdateDetailRepair = 'api/PhieuSuaChua/update-phieu-suachua-dichvu';
  static String updateTrangThaiGiaoHang = 'api/DonHangThueVc/update-trang-thai';
  static String getTrangThaiGiaoHang = 'api/DonHangThueVc/search-v2';
  // LOG ORDER AND WARE HOUSE
  static String SaveLog = 'api/lich-su-thao-tac/save';
  static String DeleteLog = 'api/lich-su-thao-tac/delete/';
  static String GetListLog = 'api/lich-su-thao-tac/search';

  // TIME KEEPING
  static String GetListDivision = 'api/quan-ly-cham-cong/danh-sach-phan-ca';
  static String ChooseDivision = 'api/quan-ly-cham-cong/cham-cong?idPhanCa=';
  static String GetHistoryTimeKeeping = 'api/quan-ly-cham-cong/danh-sach-cham-cong';
  static String GetListStaff = 'api/User/search?txtSearch=&pageIndex=1&pageSize=100000';
  static String GetTimeKeeping = 'api/quan-ly-cham-cong/danh-sach-yeu-cau';

  // TRUNCATE
  static String Truncate = 'api/v1/server/truncate-data/';
}