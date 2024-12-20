import 'package:flutter/material.dart';
import 'package:sekolator/presentation/pages/inventory/manage_inventory_page.dart';
import 'package:sekolator/presentation/pages/inventory/review_inventory_page.dart';
import 'package:sekolator/presentation/pages/report/report_page.dart';
import 'package:sekolator/presentation/pages/profile/profile_page.dart';
import 'package:sekolator/data/datasources/local/local_storage.dart';
import 'package:sekolator/domain/entities/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<User?>(
          future: LocalStorage.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading user data'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('User not found'));
            }

            final user = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Welcome 👋 ${user.username}',
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.person),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfilePage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 64),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ManageInventoryPage()),
                    );
                  },
                  child: const Text('Pengelolaan Barang'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 128),
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 64),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ReviewInventoryPage()),
                    );
                  },
                  child: const Text('Tinjau Barang'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 128),
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 64),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ReportPage()),
                    );
                  },
                  child: const Text('Laporan'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 128),
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
