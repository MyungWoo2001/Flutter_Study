import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

class UserService {
  static const String baseUrl = 'http://192.168.1.101:3000/api/users';

  Future<List<User>> fetchUsers() async {
    final res = await http.get(Uri.parse(baseUrl));
    if(res.statusCode == 200) {
      List list = jsonDecode(res.body);
      return list.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception("Faild to load User: ${res.statusCode}");
    }
  }

  Future<void> addUser(User user) async {
    final URL = Uri.parse(baseUrl);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(user.toJson());
    
    await http.post(URL, headers: headers, body: body);
  }

  Future<void> putUser(User user) async {
    final URL = Uri.parse('$baseUrl/${user.id}');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(user.toJson());

    final res = await http.put(URL, headers: headers, body: body);
    if(res.statusCode == 200) {
      print("User updated successfully");
    } else if (res.statusCode == 404) {
      print("User not found");
    } else {
      print("Failed to update user. Status code: ${res.statusCode}");
    }
  }

  Future<void> deleteUser(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}