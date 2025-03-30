import 'package:flutter/material.dart';
import 'package:mbele/main.dart';
import 'package:mbele/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Infopage extends StatefulWidget {
  const Infopage({super.key});

  @override
  State<Infopage> createState() => _InfopageState();
}

class _InfopageState extends State<Infopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CircleAvatar(
            child: Text(
              Provider.of<UserProvider>(
                context,
                listen: false,
              ).username[0].toUpperCase(),
            ),
          ),
          const SizedBox(height: 30),
          Text(context.read<UserProvider>().username),
          ElevatedButton(
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).logout();
              if (!Provider.of<UserProvider>(context, listen: false).logged) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
