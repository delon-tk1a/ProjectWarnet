import 'dart:math';
import 'package:flutter/material.dart';
import '../models/pelanggan.dart';
import '../models/warnet.dart';
import './customer_data_screen.dart'; // Import CustomerDataScreen

class WarnetBillingScreen extends StatefulWidget {
  @override
  _WarnetBillingScreenState createState() => _WarnetBillingScreenState();
}

class _WarnetBillingScreenState extends State<WarnetBillingScreen> {
  final _namaPelangganController = TextEditingController();
  String _jenisPelanggan = 'Umum';
  int _jamMasuk = 0; // Mengganti TimeOfDay dengan int
  int _jamKeluar = 0; // Mengganti TimeOfDay dengan int
  double _totalBayar = 0.0;
  String _kodePelanggan = '';

  // List untuk menyimpan data pelanggan
  List<Pelanggan> _pelangganList = [];

  void _generateRandomKodePelanggan() {
    final random = Random();
    // Menghasilkan kode pelanggan yang unik
    _kodePelanggan = 'KODE${random.nextInt(10000)}';
  }

  void _calculateTotal() {
    DateTime now = DateTime.now();
    DateTime jamMasuk = DateTime(now.year, now.month, now.day, _jamMasuk);
    DateTime jamKeluar = DateTime(now.year, now.month, now.day, _jamKeluar);

    // Generate unique kode pelanggan setiap kali total dihitung
    _generateRandomKodePelanggan();

    Warnet warnet = Warnet(
      pelanggan: Pelanggan(
        kodePelanggan: _kodePelanggan,
        namaPelanggan: _namaPelangganController.text,
        jenisPelanggan: _jenisPelanggan,
      ),
      tglMasuk: now,
      jamMasuk: jamMasuk,
      jamKeluar: jamKeluar,
    );

    // Menyimpan pelanggan ke dalam list
    _pelangganList.add(warnet.pelanggan);

    setState(() {
      _totalBayar = warnet.getTotalBayar();
    });
  }

  void _viewCustomerData() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CustomerDataScreen(_pelangganList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warnet Billing'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _viewCustomerData, // Tombol untuk melihat data pelanggan
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informasi Pelanggan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Input Nama Pelanggan
            TextField(
              controller: _namaPelangganController,
              decoration: InputDecoration(
                labelText: 'Nama Pelanggan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Dropdown untuk Jenis Pelanggan
            Text('Jenis Pelanggan:'),
            DropdownButtonFormField<String>(
              value: _jenisPelanggan,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(child: Text('Umum'), value: 'Umum'),
                DropdownMenuItem(child: Text('VIP'), value: 'VIP'),
                DropdownMenuItem(child: Text('GOLD'), value: 'GOLD'),
              ],
              onChanged: (value) {
                setState(() {
                  _jenisPelanggan = value!;
                });
              },
            ),
            SizedBox(height: 16),

            // Input Jam Masuk
            TextField(
              decoration: InputDecoration(
                labelText: 'Jam Masuk (0-23)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _jamMasuk = int.tryParse(value) ?? 0;
              },
            ),
            SizedBox(height: 16),

            // Input Jam Keluar
            TextField(
              decoration: InputDecoration(
                labelText: 'Jam Keluar (0-23)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _jamKeluar = int.tryParse(value) ?? 0;
              },
            ),
            SizedBox(height: 20),

            // Button untuk Menghitung Total
            Center(
              child: ElevatedButton(
                onPressed: _calculateTotal,
                child: Text('Hitung Total', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 20),

            // Tampilkan Total Bayar
            Text(
              'Total Bayar: Rp ${_totalBayar.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
