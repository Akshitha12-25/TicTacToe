import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(decoration: InputDecoration(labelText: "Email")),
              TextField(
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text("Login"),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Forgot Password"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.g_mobiledata), onPressed: () {}),
                  IconButton(icon: Icon(Icons.facebook), onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
