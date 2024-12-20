import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DownloadReportPage extends StatelessWidget {
  const DownloadReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unduh Laporan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Laporan Bulanan Januari'),
              onTap: () {
                _downloadReport('https://example.com/report_january.pdf', 'Laporan_Januari.pdf');
              },
            ),
            ListTile(
              title: const Text('Laporan Bulanan Februari'),
              onTap: () {
                _downloadReport('https://example.com/report_february.pdf', 'Laporan_Februari.pdf');
              },
            ),
            ListTile(
              title: const Text('Laporan Bulanan Maret'),
              onTap: () {
                _downloadReport('https://example.com/report_march.pdf', 'Laporan_Maret.pdf');
              },
            ),
            // Tambahkan lebih banyak laporan sesuai kebutuhan
          ],
        ),
      ),
    );
  }

  Future<void> _downloadReport(String url, String fileName) async {
    try {
      // Mendapatkan direktori penyimpanan
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/$fileName';

      // Mengunduh file
      Dio dio = Dio();
      await dio.download(url, filePath);

      // Menampilkan pesan sukses
      print('File berhasil diunduh: $filePath');
      // Anda bisa menambahkan logika untuk menampilkan dialog atau snackbar di sini
    } catch (e) {
      print('Gagal mengunduh file: $e');
      // Anda bisa menambahkan logika untuk menampilkan pesan kesalahan di sini
    }
  }
}
