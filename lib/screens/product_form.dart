import 'package:flutter/material.dart';
import 'package:saitamapensiunjerseystore/widgets/left_drawer.dart';

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
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Add Product Form',
              ),
            ),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
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
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.indigo),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Produk berhasil disimpan!'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Judul: $_name'),
                                          Text('Isi: $_description'),
                                          Text('Harga: $_price'),
                                          Text('Kategori: $_category'),
                                          Text('Thumbnail: $_thumbnail'),
                                          Text(
                                              'Unggulan: ${_isFeatured ? "Ya" : "Tidak"}'),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _formKey.currentState!.reset();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
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
