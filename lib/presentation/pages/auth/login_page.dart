import 'package:flutter/material.dart';
import 'register_page.dart';
import 'package:sekolator/presentation/pages/home/home_page.dart';
import 'package:sekolator/data/datasources/local/local_storage.dart';
import 'package:sekolator/domain/entities/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final TextEditingController emailOrUsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _showLoginResult(BuildContext context, bool success) {
    final message = success ? 'Login Berhasil!' : 'Login Gagal. Coba lagi.';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hasil Login'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                if (success) {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } else {
                  Navigator.of(context).pop();
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
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailOrUsernameController,
              decoration: const InputDecoration(
                labelText: 'Email atau Username',
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
                // Logika untuk login
                User? userData = await LocalStorage.getUserData();
                bool loginSuccess = false;

                if (userData != null &&
                    (userData.email == emailOrUsernameController.text ||
                     userData.username == emailOrUsernameController.text) &&
                    passwordController.text.isNotEmpty) {
                  loginSuccess = true; // Ganti dengan logika validasi password yang sebenarnya
                }

                _showLoginResult(context, loginSuccess);
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text('Belum punya akun? Daftar di sini'),
            ),
          ],
        ),
      ),
    );
  }
}
