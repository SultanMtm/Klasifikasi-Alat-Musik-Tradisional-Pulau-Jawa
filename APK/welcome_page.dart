import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: const [
          Text(
            "🎼 Selamat Datang di Aplikasi Klasifikasi Alat Musik Tradisional",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            "Aplikasi ini membantu mengenali alat musik tradisional Indonesia berbasis gambar secara cepat dan akurat.\n"
            "\nCara Menggunakan Aplikasi:\n"
            "1. Klik menu Prediction.\n"
            "2. Upload atau ambil foto alat musik.\n"
            "3. Sistem akan memprediksi dan menampilkan deskripsi alat musik.\n"
            "4. Untuk melihat semua informasi alat musik, klik menu Information.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 32),
          Divider(color: Colors.white),
        ],
      ),
    );
  }
}
