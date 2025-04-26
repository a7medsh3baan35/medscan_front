import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              user?.name ?? 'No Name',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(user?.email ?? 'No Email'),
            const SizedBox(height: 30),
            
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      currentName: user?.name ?? '',
                      currentEmail: user?.email ?? '',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0a66c2)),
              child: const Text('Edit Profile', style: TextStyle(color: Colors.white),),
            ),
            
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Log Out',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}