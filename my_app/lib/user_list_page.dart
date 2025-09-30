import 'package:flutter/material.dart';
import 'package:my_app/user_input.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';
import 'user_edit.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override  
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override  
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<UserProvider>(context, listen: false).loadingUsers());
  }

  @override  
  Widget build(BuildContext context) {  
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(  
      appBar: AppBar(title: const Text("Users")),
      body: provider.loading 
      ? const Center(child: CircularProgressIndicator()) 
      : ListView.builder (  
        itemCount: provider.users.length,
        itemBuilder: (context, index) {
          final user = provider.users[index];
          return ListTile(  
            title: Text(user.name),
            subtitle: Text("Age: ${user.mail}"),
            trailing: IconButton(  
              icon: const Icon(Icons.delete),
              onPressed: () {
                final deletedUser = user;
                var deleted = true;
                provider.deleteUserFromUI(user.id);
                
                final messenger = ScaffoldMessenger.of(context);
                messenger.hideCurrentSnackBar();
                messenger.showSnackBar(  
                  SnackBar(
                    content: Text('User ${user.name} deleted!!!'),
                    duration: Duration(seconds: 2),
                    backgroundColor: const Color.fromARGB(255, 24, 67, 102),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(  
                      borderRadius: BorderRadius.circular(12),
                    ),
                    action: SnackBarAction(  
                      label: "Undo",
                      onPressed: () {
                        deleted = false;
                        print("Undo");
                        provider.addUserToUI(deletedUser);
                      }
                    )
                  ),
                );
                Future.delayed(const Duration(seconds: 2), () {
                  if(deleted){
                    provider.deleteUser(user.id);
                    print("User deleted");
                  }
                });
                
              }
            ),
            onTap: () async {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => UserEdit(user: user)),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(  
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.push(  
            context, 
            MaterialPageRoute(builder: (context) => NewUserInput()),
          );
        },
      ),
    );
  }
}