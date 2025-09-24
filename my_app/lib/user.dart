class User {
  final int id;
  final String name;
  final int age;

  User({required this.id, required this.name, required this.age});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['id'] as num).toInt(),
      name: json['name'],
      age: (json['age'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'age': age,
    };
  }
}