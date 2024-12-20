import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sekolator/presentation/pages/auth/login_page.dart'; // Impor halaman login

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<Map<String, String?>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading profile data'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found'));
          }

          final userData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Text('Nama: ${userData['name']}', style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Email: ${userData['email']}', style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  child: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<Map<String, String?>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('userName'); // Ambil nama pengguna
    String? email = prefs.getString('userEmail'); // Ambil email pengguna
    return {'name': name, 'email': email};
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false, // Hapus semua route sebelumnya
                );
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}
