
// Role user
const String ROLE_ADMIN = 'admin';
const String ROLE_NV = 'tmdt';
const String ROLE_KH = 'khachhang';
const String ROLE_GIAOHANG = 'giaohang';
const String ROLE_THUKHO = 'giaohang';

final baoCaoItems = ['Tổng quan'];
final donHangItems = ['Danh sách đơn hàng'];
final sanPhamItems = [
  'Danh sách sản phẩm',
];
final khoItems = ['Xuất nhập kho', 'Chuyển kho', 'Đặt hàng TQ'];
final khachHangItems = ['Danh sách khách hàng'];

final donHangFilterMenu = [
  'Cửa hàng',
  'Trạng thái',
  'Sản phẩm',
  'Khách hàng',
];

final sanPhamFilterMenu = [
  'Tên/Mã/Mã vạch',
  'ID',
  'Cửa hàng',
  'Danh mục',
  'IMEI'
];

final trangThaiList = ['Hoàn thành', 'Chưa hoàn thành', 'Trong quá trình'];

// Page Size
final int kPageSize = 10;
// Home menu drawer name
const BAO_CAO_TONG_QUAN = 'Tổng quan';

const DON_HANG_DS = 'Danh sách đơn hàng';
const SAN_PHAM_DS = 'Danh sách sản phẩm';
const KHACH_HANG_DS = 'Danh sách khách hàng';
const THONG_TIN_CA_NHAN_MENU = 'Thông tin cá nhân';
const XNK_KHO = 'Xuất nhập kho';
const CHUYEN_KHO = 'Chuyển kho';
const PYC_XNK = 'Đặt hàng TQ';
const DS_KH_DON = 'Danh sách đơn cá nhân';
const CHANGE_PSW = 'Đổi mật khẩu';

final trangThaiDonList = [
  'Tạo đơn thành công',
  'Đang nhặt hàng',
  'Đã xác nhận hàng hoá',
  'Đang vận chuyển',
  'Hoàn thành'
];
final trangThaiDonWithInitial = [
  'Trạng thái đơn hàng',
  'Tạo đơn thành công',
  'Đang nhặt hàng',
  'Đã xác nhận hàng hoá',
  'Đang vận chuyển',
  'Hoàn thành'
];

final kiemHangList = [
  'Cho xem, không thử hàng',
  'Cho xem và thử hàng',
  'Không cho xem hàng',
];

final hinhThucVanChuyen = [
  'liên tỉnh',
  'tự vận chuyển',
  'không vận chuyển',
  'nội thành'
];
final String ErrorMessage = "Không có kết nối internet hoặc Server từ chối yêu cầu, Vui lòng thử lại sau vài phút";