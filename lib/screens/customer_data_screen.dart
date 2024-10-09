import 'package:flutter/material.dart';
import '../models/pelanggan.dart';

class CustomerDataScreen extends StatelessWidget {
  final List<Pelanggan> pelangganList;

  CustomerDataScreen(this.pelangganList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pelanggan'),
      ),
      body: ListView.builder(
        itemCount: pelangganList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pelangganList[index].namaPelanggan),
            subtitle: Text(
                'Kode: ${pelangganList[index].kodePelanggan} - Jenis: ${pelangganList[index].jenisPelanggan}'),
          );
        },
      ),
    );
  }
}
