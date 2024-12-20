import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryPage extends StatelessWidget {
  final String category;

  const CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: FutureBuilder<List<String>>(
        future: _getItemsByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading items'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items found'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final itemDetails = items[index].split(',');
              return ListTile(
                title: Text(itemDetails[0]), // Nama Barang
                subtitle: Text('Kategori: ${itemDetails[1]}, Jumlah: ${itemDetails[2]}'),
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

  Future<List<String>> _getItemsByCategory(String category) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? items = prefs.getStringList('inventory') ?? [];
    return items.where((item) => item.split(',')[1] == category).toList();
  }
}
