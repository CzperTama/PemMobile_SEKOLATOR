import 'package:flutter/material.dart';
import 'category_page.dart'; // Impor halaman kategori
import 'list_loan.dart'; // Impor halaman daftar peminjaman

class ReviewInventoryPage extends StatelessWidget {
  const ReviewInventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tinjau Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            _buildCategoryButton(context, 'Perangkat Teknologi'),
            _buildCategoryButton(context, 'Peralatan Pendidikan'),
            _buildCategoryButton(context, 'Fasilitas dan Perabotan'),
            _buildCategoryButton(context, 'Kebersihan dan Pemeliharaan'),
            _buildCategoryButton(context, 'Persediaan Konsumsi dan Logistik'),
            _buildCategoryButton(context, 'Peminjaman Barang'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String category) {
    return ElevatedButton(
      onPressed: () {
        if (category == 'Peminjaman Barang') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListLoan()), // Navigasi ke ListLoan
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryPage(category: category)),
          );
        }
      },
      child: Text(category),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 70),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}
