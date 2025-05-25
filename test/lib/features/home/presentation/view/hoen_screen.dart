import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test/features/auth/domain/entities/user_entity.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Text(user.email ?? ""),
          SizedBox(height: 20,),
          Text(user.name ?? "null"),
          SizedBox(height: 20,),
          Text(user.uId ?? ""),
        ],
      )
    );
    
  }
}

