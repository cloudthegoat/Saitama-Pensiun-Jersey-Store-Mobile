# saitamapensiunjerseystore

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Jawaban Pertanyaan Tugas Individu 7

## 1) Apa itu *widget tree* dan bagaimana hubungan parent–child bekerja?

- **Widget tree** adalah struktur hierarki yang menyusun UI Flutter. Setiap node adalah sebuah widget yang **mendeskripsikan** tampilan dan perilaku (bukan elemen visual langsung).
- Hubungan **parent → child** berarti:
  - Parent **menyusun** dan **memberi batasan (constraints)** kepada child.
  - Child **mengukur diri (size)** sesuai constraints, lalu melaporkan kembali ukurannya ke parent.
  - Parent kemudian **menentukan posisi** child.


## 2) Widget yang digunakan dalam proyek & fungsinya

Berikut daftar widget yang dipakai dalam proyek ini (berdasarkan `lib/main.dart` dan `lib/menu.dart`), beserta fungsinya.

### Custom Widgets

- _lib/main.dart_ (line 8) **`MyApp`**: Root widget aplikasi; memasang `MaterialApp` dan tema.
- _lib/menu.dart_ (line 3) **`MyHomePage`**: Halaman utama; membangun `Scaffold` dengan `AppBar`, info, dan grid menu.
- _lib/menu.dart_ (line 96) **`InfoCard`**: Kartu info sederhana untuk menampilkan label dan nilai (NPM/Name/Class).
- _lib/menu.dart_ (line 136) **`ItemCard`**: Tile menu yang bisa ditekan; menampilkan ikon + teks dan memicu `SnackBar`.

### Material/Flutter Widgets

- _lib/main.dart_ (line 14) **`MaterialApp`**: Kerangka aplikasi Material; atur tema, navigator, dan `home`.
- _lib/menu.dart_ (line 19) **`Scaffold`**: Struktur halaman Material (`AppBar`, `body`, `SnackBar`).
- _lib/menu.dart_ (line 21) **`AppBar`**: Bilah atas halaman dengan judul.
- _lib/menu.dart_ (line 23) **`Text`**: Menampilkan teks (judul, konten, label tombol).
- _lib/menu.dart_ (line 34) **`Padding`**: Menambahkan jarak di sekitar child.
- _lib/menu.dart_ (line 37) **`Column`**: Menyusun widget secara vertikal.
- _lib/menu.dart_ (line 41) **`Row`**: Menyusun widget secara horizontal.
- _lib/menu.dart_ (line 51) **`SizedBox`**: Spasi/ukuran tetap untuk jarak antar elemen.
- _lib/menu.dart_ (line 54) **`Center`**: Memusatkan child di dalam parent.
- _lib/menu.dart_ (line 72) **`GridView.count`**: Grid dengan jumlah kolom tetap (3) untuk daftar `ItemCard`.
- _lib/menu.dart_ (line 106) **`Card`**: Kartu Material dengan elevasi (dipakai di `InfoCard`).
- _lib/menu.dart_ (line 109) **`Container`**: Wadah serbaguna (ukuran, padding) di `InfoCard`/`ItemCard`.
- _lib/menu.dart_ (line 145) **`Material`**: Menyediakan konteks Material (warna, shape) untuk efek ripple.
- _lib/menu.dart_ (line 151) **`InkWell`**: Deteksi tap dengan efek gelombang (ripple).
- _lib/menu.dart_ (line 169) **`Icon`**: Menampilkan ikon Material pada `ItemCard`.
- _lib/menu.dart_ (line 158) **`SnackBar`**: Pesan ringan sementara di bagian bawah layar.

### Inherited Widgets yang Diakses via `context`

- _lib/menu.dart_ (line 155) **`ScaffoldMessenger`**: Mengelola dan menampilkan `SnackBar` pada `Scaffold`.
- _lib/menu.dart_ (line 111) **`MediaQuery`**: Mengakses ukuran layar untuk perhitungan lebar kartu.
- _lib/menu.dart_ (line 31) **`Theme`**: Mengakses skema warna/tema melalui `Theme.of(context)`.


## 3) Fungsi `MaterialApp` dan mengapa sering jadi *root*

`MaterialApp` adalah *convenience widget* yang menyiapkan fondasi aplikasi **Material Design**:

- Menyediakan **navigator** & *routing* (`Navigator`, `onGenerateRoute`, `routes`, `onUnknownRoute`).
- Menyediakan **tema** (`ThemeData`), **typography**, **localizations**, **text direction**, dan **media query**.
- Mengaktifkan *material behavior* untuk widget seperti `Scaffold`, `AppBar`, `SnackBar`, `FloatingActionButton`, dsb.

**Mengapa jadi root?** Karena banyak widget Material (mis. `Scaffold`) **mengandalkan** konteks yang disediakan `MaterialApp` (theme, navigator, localization). Alternatifnya ada `CupertinoApp` (gaya iOS) atau `WidgetsApp` (versi minimal tanpa opini).


## 4) Perbedaan `StatelessWidget` vs `StatefulWidget` dan kapan memilih

**StatelessWidget**
- Tidak menyimpan *mutable state* internal.
- `build()` dipanggil ulang saat **input (properties / InheritedWidgets)** berubah.
- Cocok untuk UI statis atau yang sepenuhnya ditentukan oleh parameter.

**StatefulWidget**
- Memiliki objek `State` terpisah yang menyimpan *mutable state* melintasi *rebuild*.
- Panggil `setState()` untuk memberi tahu Flutter bahwa bagian UI perlu dibangun ulang.
- Cocok untuk UI yang berubah seiring interaksi pengguna, animasi, *async loading*, atau timer.

**Kapan memilih?**
- Pilih **Stateless** jika UI hanya bergantung pada *input* dan tidak ada status internal yang berubah.
- Pilih **Stateful** jika perlu menyimpan/mengelola status yang berubah dari waktu ke waktu (mis. tampilan *loading*, *form validation*, animasi, *tab selection*).


## 5) Apa itu `BuildContext`, mengapa penting, dan bagaimana memakainya?

- `BuildContext` adalah **penunjuk posisi** sebuah widget dalam **widget tree**.
- Berguna untuk **mencari ke atas tree** (ancestor lookup) demi mendapatkan data/servis dari:
  - `InheritedWidget` (mis. `Theme.of(context)`, `MediaQuery.of(context)`),
  - `Navigator.of(context)`, `ScaffoldMessenger.of(context)`, dsb.
- Penting karena banyak API Flutter **bergantung** pada konteks untuk menemukan dependensi dan batasan layout yang tepat.

Penggunaan umum di `build()`:

```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);           // akses ThemeData
  final mq = MediaQuery.of(context);         // ukuran layar, padding, dsb.
  return Scaffold(
    appBar: AppBar(title: Text('Lebar: ${mq.size.width}')),
    body: Center(
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => const HalamanBaru()),
        ),
        child: Text('Ke halaman', style: theme.textTheme.bodyLarge),
      ),
    ),
  );
}
```

## 6) *Hot reload* di Flutter & perbedaannya dengan *hot restart*

### Konsep *hot reload* di Flutter
*Hot reload* menyuntikkan perubahan kode Dart ke **Dart VM** yang sedang berjalan tanpa menghentikan aplikasi. Setelah kode diperbarui, Flutter menandai widget terkait sebagai *dirty* dan **memanggil ulang `build()`** sehingga bisa langsung melihat perubahan UI **tanpa kehilangan state** yang sudah ada.
- **State dipertahankan**: objek `State` yang sedang hidup (counter, input form, posisi tab, dsb.) tetap ada.
- **Sangat cepat** untuk iterasi UI: ubah layout, teks, atau logika tampilan, lalu lihat hasilnya seketika.
- **Batasan umum**:
  - Kode yang hanya dieksekusi sekali (mis. di `main()`, `initState()`, atau inisialisasi global) **tidak** otomatis dieksekusi ulang.
  - Perubahan struktural besar (mis. mengganti tipe/kelas inti, mengubah *signature* penting, atau berpindah dari/ke plugin/native code) sering **tidak** tercermin sempurna dengan *hot reload*.
  - Jika hasil tidak sesuai harapan setelah *reload*, lakukan *hot restart*.

---

### Perbedaan *hot reload* vs *hot restart*
- **State**  
  - *Hot reload*: **mempertahankan** state yang sedang berjalan.  
  - *Hot restart*: **menghapus** semua state—aplikasi mulai ulang dari `main()`.
- **Siklus hidup aplikasi**  
  - *Hot reload*: tidak memulai ulang aplikasi; hanya *rebuild* bagian yang berubah.  
  - *Hot restart*: memulai ulang aplikasi sepenuhnya (mirip menutup lalu membuka lagi tetapi tanpa *full rebuild* native).
- **Kecepatan**  
  - *Hot reload*: paling cepat untuk iterasi UI.  
  - *Hot restart*: sedikit lebih lambat karena seluruh aplikasi diinisialisasi ulang.
- **Kapan dipakai**  
  - *Hot reload*: saat mengubah UI/logika tampilan dan ingin **menjaga state** agar iterasi cepat.  
  - *Hot restart*: saat perubahan tidak ter-*apply* dengan *reload*, butuh **reset state total**, atau setelah mengubah hal-hal fundamental (mis. inisialisasi global, konfigurasi utama, atau integrasi plugin/native).
- **Contoh situasi**  
  - *Hot reload*: memperbaiki teks, padding, warna, tata letak `build()`.  
  - *Hot restart*: mengubah nilai awal yang ditetapkan di `initState()`, mengubah struktur objek global/singleton, atau setelah menambah dependensi yang memengaruhi *startup* aplikasi.

**Ringkasnya:** *Hot reload* = cepat dan mempertahankan state untuk iterasi UI; *Hot restart* = mulai dari nol, menghapus state, cocok saat perubahan struktural/inisialisasi perlu diterapkan ulang.