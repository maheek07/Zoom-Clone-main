import 'package:flutter/material.dart';
import 'package:zoom_meet/resources/auth_methods.dart';
import 'package:zoom_meet/utils/colors.dart';
import 'package:zoom_meet/widgets/custom_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthMethods _authMethods = AuthMethods();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(_authMethods.user.photoURL!),
          ),
          const SizedBox(height: 20),
          Text(
            _authMethods.user.displayName!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text('Email: ${_authMethods.user.email}'),
          const SizedBox(height: 40),
          CustomButton(
            text: 'Log Out',
            onPressed: () => AuthMethods().logOut(),
          ),
        ],
      ),
    );
  }
}
