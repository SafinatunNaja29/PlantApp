import 'package:flutter/material.dart';
import 'package:plantapp/screens/maps/components/native_map.dart';

class HomeMapsPage extends StatefulWidget {
  const HomeMapsPage({super.key});

  @override
  State<HomeMapsPage> createState() => _HomeMapsPageState();
}

class _HomeMapsPageState extends State<HomeMapsPage> {
  String? alamatDipilih;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Lokasi"),
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.map),
                label: const Text("Pilih Lokasi di Peta"),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NativeMap(),
                    ),
                  );
                  if (result != null && result is String) {
                    setState(() {
                      alamatDipilih = result;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              alamatDipilih == null
                  ? const Text(
                      'Belum ada alamat yang dipilih',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    )
                  : Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.network(
                              'https://maps.googleapis.com/maps/api/staticmap?center=$alamatDipilih&zoom=15&size=600x300&key=YOUR_API_KEY',
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.map, size: 80),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              alamatDipilih!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}