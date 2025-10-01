class User {
  final int id;
  String name;
  String mail;

  User({required this.id, required this.name, required this.mail});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['user_id'] as num).toInt(),
      name: json['user_name'],
      mail: json['user_mail'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'user_name': name,
      'user_mail': mail,
    };
  }
}