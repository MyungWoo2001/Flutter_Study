import 'user.dart';
import 'user_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final UserService _service = UserService();
  List<User> _users = [];
  bool _loading = false;

  List<User> get users => _users;
  bool get loading => _loading;

  Future<void> loadingUsers() async {
    _loading = true;
    notifyListeners();
    _users = await _service.fetchUsers();
    _loading = false;
    notifyListeners();
  }

  Future<void> addUser(User user) async {
    await _service.addUser(user);
    await loadingUsers();
  }

  Future<void> deleteUser(int id) async {
    await _service.deleteUser(id);
    notifyListeners();
  }

  void deleteUserFromUI(int id) {
    _users.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void addUserToUI(User user) {
    _users.add(user);
    notifyListeners();
  }
}