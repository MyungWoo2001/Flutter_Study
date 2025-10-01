import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'user_provider.dart';

class NewUserInput extends StatefulWidget {
  const NewUserInput({super.key});

  @override  
  State<NewUserInput> createState() => _NewUserInputState();
}

class _NewUserInputState extends State<NewUserInput> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mailController = TextEditingController();

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
        child: Form(
          key: _formKey,
          child: Column(  
            children: [
              TextFormField(  
                controller: _nameController, 
                decoration: InputDecoration(  
                  labelText: 'New user name:',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Plese enter name!";
                  }
                  return null;
                },
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
                child: Text("Save"),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    final name = _nameController.text;
                    final mail = _mailController.text;
                      await provider.addUser(  
                        User(id:0, name: name, mail: mail)
                      );
                    // dismiss page
                    Navigator.pop(context);
                  }     
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}