import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListLoan extends StatelessWidget {
  const ListLoan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Peminjaman'),
      ),
      body: FutureBuilder<List<String>>(
        future: _getBorrowedItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading items'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No borrowed items found'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final itemDetails = items[index].split(',');
              return ListTile(
                title: Text(itemDetails[1]), // Nama Barang
                subtitle: Text('Peminjam: ${itemDetails[0]}, Jumlah: ${itemDetails[2]}'),
                onTap: () {
                  // Logika untuk menampilkan detail barang
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<String>> _getBorrowedItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? borrowedItems = prefs.getStringList('borrowedItems') ?? [];
    return borrowedItems;
  }
}
