import 'package:sqflite/sqflite.dart';
import 'package:v_tech/app/models/user.dart';
final String tableUser = 'UserTable';
final String columnId = 'id';
final String columnIdDoanhNghiep = 'idDoanhNghiep';
final String columnIdKhachHang = 'idKhachHang';
final String columnTaiKhoan = 'taiKhoan';
final String columnTen = 'ten';
final String columnDienThoai = 'dienThoai';
final String columnEmail = 'email';
final String columnToken = 'token';
final String columnRoles = 'role';
final String columnCreateAt = 'createAt';
class VTECHDatabase{
  static Database? _database;
  static VTECHDatabase? _vtechDatabase;

  VTECHDatabase._createInstance();
  factory VTECHDatabase(){
    if (_vtechDatabase == null){
      _vtechDatabase = VTECHDatabase._createInstance();
    }
    return _vtechDatabase!;
  }

  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async{
    var dir = await getDatabasesPath();
    var path = dir + 'vtech.db';
    var database = openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute('''
          CREATE TABLE $tableUser (
          $columnId integer primary key autoincrement,
          $columnIdDoanhNghiep integer,
          $columnIdKhachHang integer,
          $columnTaiKhoan text not null,
          $columnTen text not null,
          $columnDienThoai text not null,
          $columnEmail text not null,
          $columnToken text not null,
          $columnRoles text not null,
          $columnCreateAt text not null
          )
          ''');
        }
    );
    return database;
  }

  void insertUser(User userInfo) async{
    var db = await this.database;
    await db.insert(tableUser, userInfo.toMap());
  }

  Future<List<User>> getListUser() async{
    List<User> _users = [];
    var db = await this.database;
    var result = await db.query(tableUser);
    result.forEach((element) {
      var tmp = User.fromJson(element);
      _users.add(tmp);
    });
    return _users;
  }

  Future<int> deleteUser(int? id) async{
    var db = await this.database;
    var res = await db.delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
    return res;
  }

  Future<int> updateUser(User userInfo)async{
    var db = await this.database;
    var res = await db.rawUpdate('''
        UPDATE ${tableUser}
        SET
        $columnIdDoanhNghiep = ?,
        $columnIdKhachHang = ?,
        $columnTaiKhoan = ?,
        $columnTen = ?,
        $columnDienThoai = ?,
        $columnEmail = ?,
        $columnToken = ?,
        $columnRoles = ?,
        $columnCreateAt t= ?
        WHERE ${columnId} = ?
        ''',[userInfo.idDoanhNghiep, userInfo.idKhachHang, userInfo.taiKhoan, userInfo.ten, userInfo.dienThoai, userInfo.email, userInfo.token, userInfo.role, userInfo.createdDate, userInfo.id]
    );
    return res;
  }
}