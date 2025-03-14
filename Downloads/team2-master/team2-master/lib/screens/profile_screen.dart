import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 50, backgroundImage: AssetImage("assets/profile.png")),
            SizedBox(height: 10),
            Text("Siri",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("sirip@gmail.com"),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text("Edit Profile")),
          ],
        ),
      ),
    );
  }
}
