import 'package:flutter/material.dart';
import 'package:sekolator/data/datasources/local/local_storage.dart';
import 'package:sekolator/domain/entities/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _showRegisterResult(BuildContext context, bool success) {
    final message = success ? 'Registrasi Berhasil!' : 'Registrasi Gagal. Coba lagi.';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hasil Registrasi'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                if (success) {
                  Navigator.of(context).pop(); // Tutup dialog
                  Navigator.of(context).pop(); // Kembali ke halaman login
                } else {
                  Navigator.of(context).pop(); // Hanya tutup dialog
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Logika untuk registrasi
                bool registerSuccess = true; // Ganti dengan logika registrasi yang sebenarnya
                if (registerSuccess) {
                  User newUser = User(
                    email: emailController.text,
                    username: usernameController.text,
                  );
                  await LocalStorage.saveUserData(newUser);
                  _showRegisterResult(context, registerSuccess);
                }
              },
              child: const Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}
