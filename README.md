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

# Jawaban Pertanyaan Tugas Individu 8

## 1) Perbedaan `Navigator.push()` vs `Navigator.pushReplacement()` dan kapan memakainya

### Perbedaan inti
- **`Navigator.push()`** menambahkan halaman baru di atas *stack*. Tombol **Back** akan kembali ke halaman sebelumnya.
- **`Navigator.pushReplacement()`** mengganti halaman saat ini dengan halaman baru. Tombol **Back** tidak kembali ke halaman yang diganti, tetapi ke halaman sebelum itu (jika ada).

### Kapan masing-masing sebaiknya saya pakai di *Saitama Pensiun Jersey Store*?
- Menggunakan **`push()`** untuk alur detail yang wajar kembali ke asal.
  - Contoh: dari **Katalog** ke **Detail Jersey**.
    ```dart
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(product: jersey),
      ),
    );
    ```
- Menggunakan **`pushReplacement()`** untuk alur satu-arah atau *top-level navigation* agar tidak menumpuk banyak halaman sejenis.
  - Contoh: setelah **login/registrasi sukses** menuju **Home** agar tidak bisa kembali ke layar login.
    ```dart
    Navigator.pushReplacementNamed(context, '/home');
    ```
  - Contoh: navigasi dari **Drawer** ke tujuan utama (Home/Katalog/Keranjang/Profil) supaya Back tidak berkeliling ke semua halaman *top-level* yang pernah dibuka.
    ```dart
    // Di onTap drawer item
    Navigator.pop(context); // tutup drawer
    Navigator.pushReplacementNamed(context, '/cart');
    ```

## 2) Memanfaatkan `Scaffold`, `AppBar`, dan `Drawer` untuk struktur halaman yang konsisten (sesuai proyek ini)

Di proyek Saitama Pensiun Jersey Store saya, konsistensi struktur halaman dicapai dengan pola yang sama pada setiap halaman top-level: `Scaffold` + `AppBar` + `Drawer` yang dibagikan.

- Halaman top-level menggunakan `Scaffold` dengan `drawer: LeftDrawer()` sehingga menu samping dan header selalu sama di seluruh halaman.
  - Implementasi: `MyHomePage` di `lib/screens/menu.dart` dan `ProductFormPage` di `lib/screens/product_form.dart` sama-sama memasang `LeftDrawer`.
- `AppBar` konsisten hadir di setiap halaman sebagai bilah atas:
  - `MyHomePage` menampilkan judul “Saitama Pensiun Jersey Store” dengan teks putih, dan `backgroundColor` mengikuti tema melalui `Theme.of(context).colorScheme.primary`.
  - `ProductFormPage` menampilkan judul “Add Product Form” dengan `backgroundColor: Colors.indigo` dan `foregroundColor: Colors.white`.
- `LeftDrawer` didefinisikan sekali di `lib/widgets/left_drawer.dart` dan dipakai ulang di semua halaman:
  - Memiliki `DrawerHeader` berisi nama toko + tagline dengan latar `Colors.blue`.
  - Berisi item navigasi `ListTile` (Home, Add Product, See Product). Masing-masing menavigasi menggunakan `Navigator.pushReplacement(...)` agar perpindahan antar halaman top-level tidak menumpuk stack.


## 3) Kelebihan `Padding`, `SingleChildScrollView`, dan `ListView` pada form + contoh

**Kelebihan layout widget pada form:**
- **`Padding`**: menjaga jarak antar elemen agar rapi, mudah di-*scan*, dan nyaman untuk tap.
- **`SingleChildScrollView`**: mencegah overflow saat keyboard muncul pada form yang relatif pendek; konten bisa digulir tanpa error.
- **`ListView`**: cocok untuk form panjang/dinamis (banyak field) karena mendukung pengguliran native dan pengelolaan performa lebih baik.

**Contoh penggunaan dalam aplikasi saya:**
- `Padding`
  - `lib/screens/menu.dart:37` membungkus seluruh `body` halaman Home agar konten tidak mepet tepi.
  - `lib/screens/menu.dart:63` memberi jarak pada teks sambutan (atas 16 px).
  - `lib/screens/product_form.dart:49` (dan beberapa bagian berikutnya) membungkus setiap `TextFormField` agar antar-field rapi dan konsisten.
  - `lib/widgets/left_drawer.dart:28` memberi jarak di dalam `DrawerHeader` agar judul dan tagline nyaman dibaca.
- `SingleChildScrollView`
  - `lib/screens/product_form.dart:44` membungkus kolom form supaya layar kecil/tampil keyboard tidak menimbulkan overflow.
  - `lib/screens/product_form.dart:224` dipakai di dalam `AlertDialog.content` agar isi dialog tetap bisa digulir saat teksnya panjang.
- `ListView`
  - `lib/widgets/left_drawer.dart:11` untuk menyusun item menu pada `Drawer` sehingga daftar bisa digulir saat tinggi layar terbatas.


## 4) Menyesuaikan Tema Agar Konsisten dengan Brand Toko

Untuk menyesuaikan warna tema agar aplikasi Football Shop saya memiliki identitas visual yang konsisten dengan brand toko (website Saitama Pensiun Jersey Store), ada beberapa hal yang akan saya lakukan nantinya, beberapa di antaranya adalah sebagai berikut.

- Menetapkan palet brand yang jelas.
  - Warna utama: hitam untuk elemen struktur dan navigasi.
  - Warna kedua: oranye untuk aksen, aksi utama, dan penanda status positif/aktif.
  - Memastikan warna kontras teks/ikon di atas keduanya memadai.

- Mengatur tema global aplikasi agar seluruh komponen mewarisi skema warna yang sama.
  - Menggunakan skema warna Material modern sehingga turunan warna (surface, background, outline, dsb.) tetap harmonis.
  - Menghindari menetapkan warna secara acak di masing-masing widget. Dengan kata lain, merujuk ke warna tema agar konsisten.

- Menerapkan konsistensi komponen utama.
  - App bar: latar hitam dengan teks/ikon kontras yang konsisten di semua halaman.
  - Navigasi: menggunakan oranye sebagai penanda item aktif atau badge/indikator notifikasi.
  - Tombol: menggunakan oranye untuk aksi utama (misalnya beli/checkout) dan menggunakan varian yang kontras untuk aksi sekunder.
  - Floating action button dan elemen interaktif lain: menggunakan oranye agar menonjol, tapi tetap selaras.
  - Input/form: Memastikan fokus/aktif dan elemen bantu (label, border, ikon) memanfaatkan warna sekunder untuk penekanan yang halus.

- Menyesuaikan elemen pendukung.
  - Drawer dan header: menggunakan latar hitam dengan tipografi putih yang tegas; menggunakan oranye untuk ikon/indikator pilihan.
  - Kartu dan permukaan (surface): menjaga keterbacaan di atas latar gelap; menggunakan bayangan dan kontras yang cukup.

- Menyiapkan varian mode gelap/terang tanpa mengubah identitas.
  - Mempertahankan hitam sebagai jangkar visual dan oranye sebagai aksen; sesuaikan tingkat kecerahan agar tetap nyaman dilihat.
  - Memperhatikan aksesibilitas (rasio kontras) di kedua mode.

- Standarisasi dan pemeliharaan.
  - Mengelompokkan definisi warna brand di satu tempat agar mudah dirawat dan dipakai ulang.
  - Menguji konsistensi di seluruh layar (home, form produk, daftar, detail) dan memperbaiki bila ada komponen yang masih memakai warna “hard-coded”.