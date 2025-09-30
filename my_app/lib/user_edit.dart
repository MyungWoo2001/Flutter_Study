import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'user_provider.dart';

class UserEdit extends StatefulWidget {
  final User user;
  const UserEdit({super.key, required this.user});

  @override  
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final TextEditingController _newNameController = TextEditingController();
  User editUser = User(id: 0, name: "", mail: "");

  @override  
  void initState() {
    super.initState();
    _newNameController.text = widget.user.name;
    editUser = widget.user;
  }

  @override  
  Widget build(BuildContext context){
    final provider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("User Edit")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(  
              controller: _newNameController,
              decoration: InputDecoration(
                labelText: "User's new name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                editUser.name = _newNameController.text;
                provider.putUser(editUser);
                print("id: ${editUser.id}");
                Navigator.pop(context);
              },
              child: Text("Save"),
            )
          ],
        )
      )
    );
  }
  
}