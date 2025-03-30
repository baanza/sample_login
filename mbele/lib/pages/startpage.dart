import 'package:flutter/material.dart';
import 'package:mbele/pages/infopage.dart';
import 'package:mbele/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Startpage extends StatefulWidget {
  const Startpage({super.key});

  @override
  State<Startpage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Startpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          GestureDetector(
            child: CircleAvatar(
              child: Text(
                context.read<UserProvider>().username[0].toUpperCase(),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Infopage()),
              );
            },
          ),
        ],
      ),
      body: Center(child: Text(context.read<UserProvider>().username)),
    );
  }
}
