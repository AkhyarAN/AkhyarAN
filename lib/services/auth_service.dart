import "package:aplikasi_sederhana/models/user.dart";

class AuthService {
  final List<User> _users = []; // Menggunakan final

  // Registrasi pengguna
  bool register(String username, String password) {
    if (_users.any((user) => user.username == username)) {
      return false; // Username sudah ada
    }
    _users.add(User(username: username, password: password));
    return true; // Registrasi berhasil
  }

  // Login pengguna
  User? login(String username, String password) {
    return _users.firstWhere(
      (user) => user.username == username && user.password == password,
      orElse: () =>
          User(username: '', password: ''), // Mengembalikan User kosong
    );
  }
}
