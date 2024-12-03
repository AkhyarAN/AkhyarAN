import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'dashboard_screen.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

 void _login() {
  final username = _usernameController.text;
  final password = _passwordController.text;

  print('Attempting to login with username: $username and password: $password');

   // Validasi input
  if (username.isEmpty || password.isEmpty) {
    setState(() {
      _errorMessage = 'Username dan password tidak boleh kosong';
    });
    return; // Hentikan eksekusi jika input kosong
  }

  final user = _authService.login(username, password);
  if (user != null) {
    // Jika login berhasil, navigasi ke Dashboard
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  } else {
    setState(() {
      _errorMessage = 'Username atau password salah';
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (_errorMessage != null) ...[
              Text(_errorMessage!, style: TextStyle(color: Colors.red)),
            ],
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              },
              child: Text('Belum punya akun? Daftar di sini'),
            ),
          ],
        ),
      ),
    );
  }
}