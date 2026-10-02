import 'package:flutter/material.dart';

import 'models/data.dart';
import 'views/home_page.dart';
import 'views/login_page.dart';

// Kelas utama aplikasi yang bertugas mengatur state global aplikasi.
class KatalogSepatuApp extends StatefulWidget {
  const KatalogSepatuApp({super.key});

  @override
  State<KatalogSepatuApp> createState() => _KatalogSepatuAppState();
}

class _KatalogSepatuAppState extends State<KatalogSepatuApp> {
  // Variabel ini menyimpan data user yang sedang login.
  // Jika null, berarti user belum login dan tampilan akan diarahkan ke LoginPage.
  Account? _user;

  // Dipanggil saat proses login berhasil.
  void _handleLogin(Account user) {
    setState(() => _user = user);
  }

  // Dipanggil saat user logout.
  void _handleLogout() {
    setState(() => _user = null);
  }

  @override
  Widget build(BuildContext context) {
    // Warna utama brand aplikasi, digunakan untuk tema visual.
    const brandRed = Color(0xFFC92836);

    return MaterialApp(
      title: 'Katalog Sepatu',
      debugShowCheckedModeBanner: false,

      // Tema aplikasi dibuat agar tampilan lebih konsisten dan menarik.
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandRed,
          primary: brandRed,
          surface: const Color(0xFFFFFBF7),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFBF7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFFBF7),
          foregroundColor: Color(0xFF292522),
          centerTitle: false,
          elevation: 0,
        ),

        // Pengaturan default untuk semua TextField dalam aplikasi.
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE8E1DA)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE8E1DA)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: brandRed, width: 1.5),
          ),
        ),
      ),

      // Jika user null, tampilkan LoginPage.
      // Jika user sudah login, tampilkan HomeShell dengan data user.
      home: _user == null
          ? LoginPage(onLogin: _handleLogin)
          : HomeShell(account: _user!, onLogout: _handleLogout),
    );
  }
}
