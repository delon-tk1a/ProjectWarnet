// lib/models/warnet.dart
import 'pelanggan.dart';

class Warnet {
  Pelanggan pelanggan;
  DateTime tglMasuk;
  DateTime jamMasuk;
  DateTime jamKeluar;
  final double tarifPerJam = 10000;

  Warnet({
    required this.pelanggan,
    required this.tglMasuk,
    required this.jamMasuk,
    required this.jamKeluar,
  });

  double getLama() {
    return jamKeluar.difference(jamMasuk).inHours.toDouble();
  }

  double getDiskon() {
    double lama = getLama();
    if (lama > 2) {
      if (pelanggan.jenisPelanggan == 'VIP') {
        return 0.02;
      } else if (pelanggan.jenisPelanggan == 'GOLD') {
        return 0.05;
      }
    }
    return 0.0;
  }

  double getTotalBayar() {
    double lama = getLama();
    double total = lama * tarifPerJam;
    double diskon = total * getDiskon();
    return total - diskon;
  }
}
