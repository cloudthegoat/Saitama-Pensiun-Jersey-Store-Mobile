import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:saitamapensiunjerseystore/models/product_entry.dart';
import 'package:saitamapensiunjerseystore/screens/product_detail.dart';
import 'package:saitamapensiunjerseystore/widgets/left_drawer.dart';
import 'package:saitamapensiunjerseystore/widgets/product_entry_card.dart';

class MyProductEntryListPage extends StatefulWidget {
  const MyProductEntryListPage({super.key});

  @override
  State<MyProductEntryListPage> createState() => _MyProductEntryListPageState();
}

class _MyProductEntryListPageState extends State<MyProductEntryListPage> {
  int? _extractUserId(CookieRequest request) {
    final Map<String, dynamic> data = request.getJsonData();

    if (data.isEmpty) {
      return null;
    }

    for (final key in ['id', 'user_id', 'userId', 'pk']) {
      final dynamic value = data[key];
      if (value is int) {
        return value;
      }
      if (value is String) {
        final parsed = int.tryParse(value);
        if (parsed != null) {
          return parsed;
        }
      }
    }
    return null;
  }

  Future<List<ProductEntry>> _fetchUserProducts(
      CookieRequest request, int userId) async {
    final response = await request.get('http://localhost:8000/json/');
    final List<ProductEntry> products = [];

    for (var d in response) {
      if (d == null) continue;
      final entry = ProductEntry.fromJson(d);
      if (entry.fields.user == userId) {
        products.add(entry);
      }
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final int? userId = _extractUserId(request);

    if (userId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Products'),
        ),
        drawer: const LeftDrawer(),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'Gagal memuat informasi pengguna. Silakan login ulang untuk melihat produk milik Anda.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<ProductEntry>>(
        future: _fetchUserProducts(request, userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Terjadi kesalahan saat memuat data: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(
              child: Text(
                'Anda belum memiliki produk apa pun.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, index) => ProductEntryCard(
              product: products[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      product: products[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
