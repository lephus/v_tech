class Role {
  int id;
  String ten;

  Role({required this.id, required this.ten});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(id: json['id'], ten: json['ten']);
  }
}