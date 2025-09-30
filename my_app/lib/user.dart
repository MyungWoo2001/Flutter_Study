class User {
  final int id;
  String name;
  String mail;

  User({required this.id, required this.name, required this.mail});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['id'] as num).toInt(),
      name: json['name'],
      mail: json['mail'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'mail': mail,
    };
  }
}