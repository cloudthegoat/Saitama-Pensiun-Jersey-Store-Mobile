import 'package:flutter/material.dart';
import 'package:saitamapensiunjerseystore/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:saitamapensiunjerseystore/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
    const ProductFormPage({super.key});

    @override
    State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    double _price = 0;
    String _description = "";
    String _category = "Jersey Premier League";
    String _thumbnail = "";
    bool _isFeatured = false;

    final List<String> _categories = [
      'Jersey Premier League',
      'Jersey La Liga',
      'Jersey Serie A',
      'Jersey Bundesliga',
      'Jersey Ligue 1',
      'Jersey Timnas Indonesia',
    ];

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Product Form'),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.25),
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          drawer: LeftDrawer(),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  // === Name ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Nama Produk",
                        labelText: "Nama Produk",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _name = value?.trim() ?? "";
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Nama produk tidak boleh kosong!";
                        }
                        if (value.trim().length < 3) {
                          return "Nama produk minimal 3 karakter!";
                        }
                        return null;
                      },
                    ),
                  ),
                  // === Price ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Harga Produk",
                        labelText: "Harga Produk",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (String? value) {
                        setState(() {
                          final sanitized = value?.trim() ?? "";
                          _price = double.tryParse(sanitized) ?? 0;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Harga produk tidak boleh kosong!";
                        }
                        final parsedPrice = double.tryParse(value.trim());
                        if (parsedPrice == null) {
                          return "Masukkan angka yang valid!";
                        }
                        if (parsedPrice < 0) {
                          return "Harga tidak boleh negatif!";
                        }
                        return null;
                      },
                    ),
                  ),
                  // === Description ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Deskripsi Produk",
                        labelText: "Deskripsi Produk",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _description = value?.trim() ?? "";
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Deskripsi produk tidak boleh kosong!";
                        }
                        if (value.trim().length < 10) {
                          return "Deskripsi minimal 10 karakter!";
                        }
                        return null;
                      },
                    ),
                  ),
                  // === Category ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Kategori",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      value: _category,
                      items: _categories
                          .map((cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(
                                    cat[0].toUpperCase() + cat.substring(1)),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _category = newValue!;
                        });
                      },
                    ),
                  ),

                  // === Thumbnail URL ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "URL Thumbnail",
                        labelText: "URL Thumbnail",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _thumbnail = value?.trim() ?? "";
                        });
                      },
                      validator: (String? value) {
                        final trimmedValue = value?.trim() ?? "";
                        if (trimmedValue.isEmpty) {
                          return "URL thumbnail tidak boleh kosong!";
                        }
                        final uri = Uri.tryParse(trimmedValue);
                        final hasValidScheme =
                            uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
                        if (uri == null || !hasValidScheme || !uri.hasAuthority) {
                          return "Masukkan URL thumbnail yang valid!";
                        }
                        return null;
                      },
                    ),
                  ),

                  // === Is Featured ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SwitchListTile(
                      title: const Text("Tandai sebagai Produk Unggulan"),
                      value: _isFeatured,
                      onChanged: (bool value) {
                        setState(() {
                          _isFeatured = value;
                        });
                      },
                    ),
                  ),
                  // === Tombol Simpan ===
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // TODO: Replace the URL with your app's URL
                            // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
                            // If you using chrome,  use URL http://localhost:8000
                            
                            final response = await request.postJson(
                              "http://localhost:8000/create-flutter/",
                              jsonEncode({
                                "name": _name,
                                "price": _price,
                                "description": _description,
                                "thumbnail": _thumbnail,
                                "category": _category,
                                "is_featured": _isFeatured,
                              }),
                            );
                            if (context.mounted) {
                              if (response['status'] == 'success') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Product successfully saved!"),
                                ));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Something went wrong, please try again."),
                                ));
                              }
                            }
                          }
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ]
              )
            ),
          ),
        );
    }
}
