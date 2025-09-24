import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/user_list_page.dart';
import 'package:my_app/user_provider.dart';

void main() {
  runApp(  
    MultiProvider(  
      providers: [  
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Crup Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UserListPage(),
    );
  }
}