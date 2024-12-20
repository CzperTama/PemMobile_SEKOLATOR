import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddInventoryPage extends StatefulWidget {
  const AddInventoryPage({Key? key}) : super(key: key);

  @override
  _AddInventoryPageState createState() => _AddInventoryPageState();
}

class _AddInventoryPageState extends State<AddInventoryPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  String? selectedCategory;

  final List<String> categories = [
    'Perangkat Teknologi',
    'Peralatan Pendidikan',
    'Fasilitas dan Perabotan',
    'Kebersihan dan Pemeliharaan',
    'Persediaan Konsumsi dan Logistik',
  ];

  Future<void> saveItem() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? items = prefs.getStringList('inventory') ?? [];
    
    String item = '${nameController.text},$selectedCategory,${quantityController.text}';
    items.add(item);
    
    await prefs.setStringList('inventory', items);
    nameController.clear();
    quantityController.clear();
    setState(() {
      selectedCategory = null; // Reset dropdown
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Barang',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              hint: const Text('Pilih Kategori'),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              decoration: const InputDecoration(
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
              onPressed: () {
                if (nameController.text.isNotEmpty && selectedCategory != null && quantityController.text.isNotEmpty) {
                  saveItem();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Barang berhasil ditambahkan!')),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
