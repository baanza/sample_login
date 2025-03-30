import 'package:flutter/material.dart';
import 'package:mbele/consts/consts.dart';
import 'package:mbele/models/user.dart';
import 'package:mbele/pages/startpage.dart';
import 'package:mbele/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController usercontroller = TextEditingController();
  bool registering = false;

  void login() async {
    String email = emailcontroller.text.trim();
    String password = passcontroller.text.trim();
    UserModel user = UserModel(email: email, password: password);
    await Provider.of<UserProvider>(context, listen: false).login(user);
    if (mounted) {
      if (Provider.of<UserProvider>(context, listen: false).logged) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Startpage()),
        );
      }
    }
  }

  void register() async {
    String username = usercontroller.text;
    String email = emailcontroller.text;
    String password = passcontroller.text;
    UserModel user = UserModel(
      username: username,
      email: email,
      password: password,
    );
    await Provider.of<UserProvider>(context, listen: false).register(user);
    if (mounted) {
      if (context.read<UserProvider>().logged) {
        Provider.of<UserProvider>(context, listen: false).username = username;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Startpage()),
        );
      }
    }
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Hi There 👋🏻",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              registering ? "Register" : "Login",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: Colors.grey[200],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    registering ? userField(usercontroller) : const SizedBox(),
                    const SizedBox(height: 20),
                    Text(
                      "Email:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    InputField(controller: emailcontroller),
                    const SizedBox(height: 30),
                    Text(
                      "Password:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    InputField(controller: passcontroller),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: registering ? register : login,
                          child: Text(registering ? "Register" : "login"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          registering
                              ? "Already Have an account? "
                              : "New here? ",
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              if (!registering) {
                                registering = true;
                              } else {
                                registering = false;
                              }
                            });
                          },
                          child: Text(
                            !registering ? "Register" : "Login",
                            style: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget userField(TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Username: "),
      const SizedBox(height: 20),
      InputField(controller: controller),
    ],
  );
}
