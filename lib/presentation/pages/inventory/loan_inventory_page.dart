import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanInventoryPage extends StatelessWidget {
  const LoanInventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController borrowerNameController = TextEditingController();
    final TextEditingController itemNameController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peminjaman Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: borrowerNameController,
              decoration: const InputDecoration(
                labelText: 'Nama Peminjam',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: itemNameController,
              decoration: const InputDecoration(
                labelText: 'Nama Barang',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: 'Jumlah',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (borrowerNameController.text.isNotEmpty &&
                    itemNameController.text.isNotEmpty &&
                    quantityController.text.isNotEmpty) {
                  await saveBorrowingData(
                    borrowerNameController.text,
                    itemNameController.text,
                    quantityController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data peminjaman berhasil disimpan!')),
                  );
                }
              },
              child: const Text('Pinjam'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveBorrowingData(String borrowerName, String itemName, String quantity) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? borrowedItems = prefs.getStringList('borrowedItems') ?? [];

    String item = '$borrowerName,$itemName,$quantity';
    borrowedItems.add(item);

    await prefs.setStringList('borrowedItems', borrowedItems);
  }
}
