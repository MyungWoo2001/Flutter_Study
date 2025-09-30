import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'user_provider.dart';

class NewUserInput extends StatefulWidget {
  const NewUserInput({super.key});

  @override  
  _NewUserInputState createState() => _NewUserInputState();
}

class _NewUserInputState extends State<NewUserInput> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  @override  
  void dispose() {
    _nameController.dispose();
    _mailController.dispose();
    super.dispose();
  }

  @override  
  Widget build (BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(  
      appBar: AppBar(title: Text("New User")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(  
          children: [
            TextField(  
              controller: _nameController, 
              decoration: InputDecoration(  
                labelText: 'New user name:',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(  
              controller: _mailController,
              decoration: InputDecoration(  
                labelText: "Mail adress",
                border: OutlineInputBorder(),
              )
            ),
            ElevatedButton(  
              onPressed: () async {
                final name = _nameController.text;
                final mail = _mailController.text;
                  await provider.addUser(  
                    User(id:0, name: name, mail: mail)
                  );
                // dismiss page
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}