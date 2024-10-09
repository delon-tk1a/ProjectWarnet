// lib/models/pelanggan.dart
class Pelanggan {
  final String kodePelanggan;
  final String namaPelanggan;
  final String jenisPelanggan; // VIP, GOLD, Umum

  Pelanggan({
    required this.kodePelanggan,
    required this.namaPelanggan,
    required this.jenisPelanggan,
  });
}
