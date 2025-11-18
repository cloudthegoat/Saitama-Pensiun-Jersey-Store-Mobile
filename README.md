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

# Jawaban Pertanyaan Tugas Individu 9

## 1. Mengapa perlu model Dart saat ambil/kirim JSON?

- **Tipe data eksplisit & null-safety**  
  Dengan model (`class ProductEntry`, `class Fields`) setiap field punya tipe yang jelas (`String`, `int`, `bool`, `DateTime`, dll.). Ini:
  - Membuat kesalahan seperti menganggap `price` adalah `String` padahal `int` langsung ketahuan di waktu kompilasi.
  - Bekerja selaras dengan null-safety: kita bisa menandai mana yang `required` dan mana yang nullable sehingga lebih aman dari `null` yang tidak terduga.

- **Validasi struktur & kontrak data**  
  Method `fromJson`/`toJson` menjadi “satu pintu” untuk validasi bentuk JSON:
  - Jika backend berubah (misalnya mengubah nama field atau tipe), error akan terlokalisir di satu tempat, tidak menyebar ke seluruh kode.
  - Kita bisa menambahkan normalisasi (trim string, parse tanggal, konversi snake_case → camelCase) di sana.

- **Keterbacaan & maintainability**  
  - Mengakses `product.fields.name` jauh lebih jelas dibanding `product['fields']['name']` yang rawan salah ketik dan tidak terproteksi tipe.
  - Refactor jadi lebih mudah: mengganti nama field cukup di class, IDE bisa membantu rename dengan aman.

- **Konsekuensi jika hanya pakai `Map<String, dynamic>` tanpa model**  
  - Kehilangan pengecekan tipe di compile time → banyak bug baru muncul di runtime (mis: `NoSuchMethodError` karena salah kunci/tipe).
  - Null-safety jadi lemah: hampir semua akses harus diawali pengecekan manual (`if (map['x'] != null) ...`).
  - Kode cepat berantakan dan sulit dirawat karena akses bersarang seperti `map['fields']['thumbnail']` tersebar di banyak file, sulit diubah jika kontrak API berubah.

## 2. Fungsi package `http` dan `CookieRequest`, dan perbedaan perannya

- **`http` (package bawaan)**  
  - Menyediakan fungsi dasar HTTP: `get`, `post`, dll.  
  - Tidak menyimpan state otentikasi (cookie/session) secara otomatis dan tidak tahu apa-apa soal Django.
  - Dipakai secara internal oleh `CookieRequest` untuk benar‑benar mengirim request ke server.

- **`CookieRequest` (dari `pbp_django_auth`)**  
  - Abstraksi lebih tinggi yang:
    - Mengelola **cookie session Django** (menyimpan dan mengirim ulang `sessionid`).
    - Menyediakan method khusus: `login`, `logout`, `postJson`, `get`, dsb.
    - Menyimpan JSON hasil login di `jsonData` agar bisa diakses seluruh aplikasi.
  - Secara internal masih memakai `http.Client`, tetapi sudah dikonfigurasi agar cocok dengan Django (termasuk `withCredentials` di web).

- **Perbedaan peran**  
  - `http`: layer transport HTTP yang generik (tidak peduli framework backend, tidak simpan session).  
  - `CookieRequest`: layer aplikasi yang paham Django + session + autentikasi, dan jadi antarmuka utama yang dipakai widget di Flutter.

## 3. Mengapa instance `CookieRequest` perlu dibagikan ke semua komponen?

- **Satu sumber kebenaran untuk status login**  
  - `CookieRequest` menyimpan `loggedIn`, `cookies`, dan `jsonData` hasil login (misalnya `username`, `id`).
  - Jika setiap widget membuat instance `CookieRequest` sendiri, maka:
    - Cookie dan status login tidak konsisten (ada yang mengira sudah login, yang lain tidak).
    - Request bisa dikirim tanpa header `Cookie` yang benar sehingga Django menganggap user belum login.

- **Berbagi session/cookie ke semua request**  
  - Dengan `Provider` di `main.dart`, satu instance `CookieRequest` di‑`watch` oleh semua widget:
    ```dart
    return Provider(
      create: (_) => CookieRequest(),
      child: MaterialApp(...),
    );
    ```
  - Semua halaman (login, daftar produk, form produk, logout, dll.) memanggil request yang sama, sehingga:
    - Session cookie yang sama selalu dikirim.
    - Update pada `jsonData` (mis: menyimpan `id` user setelah login) langsung bisa dipakai widget lain seperti halaman “My Products”.

- **Memudahkan dependency injection & testing**  
  - Dengan satu instance yang di‑inject lewat `Provider`, kode lebih mudah untuk di‑mock/test dan tidak bergantung pada singleton global yang susah dikontrol.

## 4. Konfigurasi konektivitas Flutter ↔ Django dan konsekuensi jika salah

- **`10.0.2.2` di `ALLOWED_HOSTS` (Django)**  
  - Di emulator Android, `localhost` di Flutter sebenarnya mengarah ke device/emulator, bukan ke PC host.  
  - Alamat khusus `10.0.2.2` dipakai emulator untuk mengakses `localhost` milik host (PC).  
  - Karena itu:
    - URL di Flutter Android: `http://10.0.2.2:8000/...`
    - `ALLOWED_HOSTS` Django harus mengizinkan `'10.0.2.2'` dan `'localhost'` agar request tidak ditolak (`DisallowedHost`).

- **CORS (Cross-Origin Resource Sharing) & SameSite/cookie (untuk Flutter Web)**  
  - Flutter Web jalan di origin lain (mis: `http://localhost:xxxxx`) dan mengakses Django di `http://localhost:8000`, jadi ini termasuk **cross-origin request**.
  - Jika `django-cors-headers` tidak dikonfigurasi:
    - Browser akan memblokir request/response dengan error CORS (meski di Django tidak error).
  - Cookie session Django di browser terdampak pengaturan **SameSite** dan **Secure**:
    - Jika `SameSite` terlalu ketat atau cookie tidak diizinkan untuk cross-site, session tidak akan terkirim → Django menganggap user belum login.
  - Maka perlu:
    - Mengaktifkan dan mengkonfigurasi CORS (mis: `CORS_ALLOW_ALL_ORIGINS = True` untuk dev).  
    - Memastikan cookie bisa dikirim pada request dari origin Flutter Web (setelan SameSite yang sesuai).

- **Izin akses internet di Android (`AndroidManifest.xml`)**  
  - Harus menambahkan permission:
    ```xml
    <uses-permission android:name="android.permission.INTERNET" />
    ```
  - Jika tidak, aplikasi Android tidak boleh membuat koneksi HTTP/HTTPS → semua request ke Django akan gagal (sering terlihat sebagai timeout/`ClientException: Failed host lookup`).

- **Jika konfigurasi salah**  
  - `DisallowedHost` (Django) jika host tidak ada di `ALLOWED_HOSTS`.
  - Error CORS di console browser dan `ClientException: Failed to fetch` di Flutter Web.
  - Session login tidak tersimpan/terbaca karena cookie tidak pernah terkirim.
  - Pada Android, request gagal total karena tidak ada permission internet.

## 5. Mekanisme pengiriman data dari input hingga tampil di Flutter

Alur umum (contoh: menambahkan produk dan menampilkannya kembali):

1. **Input di Flutter**  
   - Pengguna mengisi form di `ProductFormPage` (nama, harga, kategori, thumbnail, dsb.) lewat `TextFormField`, `DropdownButtonFormField`, dan `SwitchListTile`.
   - Data disimpan ke variabel state (`_name`, `_price`, `_description`, dll.) dan divalidasi dengan `validator`.

2. **Kirim ke Django (POST)**  
   - Setelah form valid dan tombol “Save” ditekan, data dikirim ke backend (dalam tugas ini contoh form masih menampilkan dialog, tapi pola umumnya adalah POST):
     - Menggunakan `CookieRequest.post`/`postJson` dengan body yang berisi field form.
     - `CookieRequest` menyisipkan cookie session jika ada, sehingga Django tahu siapa user-nya.

3. **Django memproses & menyimpan**  
   - View Django menerima `request.POST` / `json.loads(request.body)`, melakukan validasi server-side, lalu:
     - Membuat instance model (mis. `Product`) dan menyimpannya ke database.
     - Mengembalikan `JsonResponse` berisi status dan data yang relevan.

4. **Flutter menerima response**  
   - `CookieRequest` mem-parsing JSON menjadi `Map<String, dynamic>` dan mengembalikannya ke kode Flutter.
   - Flutter bisa:
     - Menampilkan `SnackBar`/`AlertDialog` keberhasilan/gagal.
     - Jika perlu, memperbarui state lokal atau melakukan `Navigator.push` ke halaman lain.

5. **Ambil daftar data (GET) dan tampilkan**  
   - Halaman `ProductEntryListPage` memanggil `fetchProduct(request)` yang melakukan:
     ```dart
     final response = await request.get('http://localhost:8000/json/');
     ```
   - Response JSON (list produk) diubah menjadi list model:
     ```dart
     for (var d in data) {
       listProduct.add(ProductEntry.fromJson(d));
     }
     ```
   - `FutureBuilder` menunggu future ini, dan ketika data siap:
     - Dibangun `ListView.builder` yang setiap item-nya adalah `ProductEntryCard`.
     - `ProductEntryCard` menampilkan thumbnail, nama, kategori, deskripsi, dan harga dari objek model `ProductEntry`.

Ringkasnya: **Input form → POST via `CookieRequest` → Django simpan & balas JSON → Flutter GET JSON → mapping ke model Dart → ditampilkan di widget list/card/detail.**

## 6. Mekanisme autentikasi: login, register, hingga logout

### a. Register
1. **Input di Flutter**  
   - Pengguna mengisi username + password + konfirmasi password di `RegisterPage`.
   - Setelah validasi dasar di sisi Flutter, tombol Register mengeksekusi:
     ```dart
     final response = await request.postJson(
       "http://localhost:8000/auth/register/",
       jsonEncode({
         "username": username,
         "password1": password1,
         "password2": password2,
       }),
     );
     ```

2. **Proses di Django** (`authentication/views.py::register`)  
   - `request.body` di‑parse sebagai JSON, dicek:
     - Apakah `password1 == password2`?
     - Apakah username belum dipakai (`User.objects.filter(username=...).exists()`)?  
   - Jika valid:
     - `User.objects.create_user(...)` dipanggil untuk membuat akun baru.
     - Django mengembalikan `JsonResponse` dengan `status: 'success'`, `username`, dan pesan sukses.
   - Jika tidak valid: mengembalikan `status: False` + pesan error yang sesuai.

3. **Tanggapan di Flutter**  
   - Flutter membaca `response['status']`:
     - Jika `'success'`: tampilkan `SnackBar` “Successfully registered!” dan arahkan ke `LoginPage`.
     - Jika gagal: tampilkan `SnackBar` “Failed to register!”.

### b. Login
1. **Input di Flutter**  
   - Pengguna memasukkan username + password di `LoginPage`.
   - Tombol Login memanggil:
     ```dart
     final response = await request.login(
       "http://localhost:8000/auth/login/",
       {'username': username, 'password': password},
     );
     ```

2. **Proses di Django** (`authentication/views.py::login`)  
   - Menerima `request.POST['username']` dan `request.POST['password']`.
   - Menggunakan `authenticate(...)` untuk memeriksa kredensial.
   - Jika user ditemukan dan aktif:
     - `auth_login(request, user)` dipanggil → Django membuat session dan mengirim cookie `sessionid` dalam header `Set-Cookie`.
     - Mengembalikan JSON:
       ```python
       return JsonResponse({
         "username": user.username,
         "id": user.id,
         "status": True,
         "message": "Login successful!",
       }, status=200)
       ```
   - Jika gagal: mengembalikan `status: False` dan pesan error (“account is disabled” atau “username/password salah”).

3. **Peran `CookieRequest` saat login**  
   - `CookieRequest.login`:
     - Mengirim POST dengan kredensial.
     - Membaca header `Set-Cookie` dari response, mengekstrak cookie (termasuk `sessionid`), dan menyimpannya.
     - Menandai `loggedIn = true` dan menyimpan JSON login di `jsonData` (berisi `username`, `id`, dll.).

4. **Tanggapan di Flutter**  
   - Jika `request.loggedIn` true:
     - Ambil `message` dan `username` dari `response`.
     - Navigasi ke `MyHomePage` dengan `Navigator.pushReplacement(...)`.
     - Tampilkan `SnackBar` “Login successful! Welcome, {username}.”
   - Jika gagal: tampilkan dialog `Login Failed` dengan pesan dari Django.

### c. Logout
1. **Aksi di Flutter**  
   - Pengguna menekan tombol “Logout” (baik dari grid menu maupun dari `LeftDrawer`).
   - Kode memanggil:
     ```dart
     final response =
         await request.logout("http://localhost:8000/auth/logout/");
     ```

2. **Proses di Django** (`authentication/views.py::logout`, diasumsikan ada)  
   - Menerima request POST dari Flutter.
   - Memanggil `auth_logout(request)` untuk menghapus session di server.
   - Mengembalikan JSON berisi `status`, `message`, dan opsi `username` untuk keperluan pesan perpisahan.

3. **Peran `CookieRequest.logout`**  
   - Mengirim POST ke endpoint logout dengan header cookie saat ini.
   - Jika server mengembalikan status 200:
     - Menandai `loggedIn = false`.
     - Mengosongkan `jsonData` dan map `cookies`.

4. **Tanggapan di Flutter**  
   - Jika `response['status']` true:
     - Ambil `message` dan `username`.
     - Tampilkan `SnackBar` “{message} See you again, {username}.”
     - Navigasi kembali ke `LoginPage` dengan `Navigator.pushReplacement(...)`.
   - Jika gagal: tampilkan `SnackBar` dengan pesan error dari Django.

**Ringkasan autentikasi:**  
Register membuat akun baru di Django, login membuat session + cookie yang disimpan di `CookieRequest` dan dipakai di semua request berikutnya, dan logout menghapus session di Django serta membersihkan cookie/status di `CookieRequest`. Flutter menampilkan halaman yang sesuai (login/home) berdasarkan status ini dan response JSON dari server.

## 7. Step-by-step mengimplementasikan checklist
1. **Menyiapkan Autentikasi & CORS di Django**
   - Membuat app baru `authentication`.
   - Menginstall serta mendaftarkan `django-cors-headers`.
   - Mengatur CORS dan cookie di `settings.py`.
   - Menambahkan IP emulator ke `ALLOWED_HOSTS`.
   - Menulis view login di `authentication/views.py`.
   - Menyusun `authentication/urls.py` dan mendaftarkan endpoint.
   - Meng-include app `authentication` ke URL utama proyek.

2. **Menyiapkan Autentikasi di Flutter**
   - Menginstall package yang diperlukan.
   - Membungkus root app dengan `Provider<CookieRequest>`.
   - Membuat halaman login (`screens/login.dart`).
   - Mengubah entry point agar memuat halaman login terlebih dahulu.

3. **Menambah Fitur Register (Django + Flutter)**
   - **Di Django**
     - Menambahkan view register di `authentication/views.py`.
     - Mendaftarkan URL register.
   - **Di Flutter**
     - Membuat halaman `screens/register.dart`.
     - Menghubungkan navigasi dari halaman login.

4. **Membuat Model Dart dari Data JSON Django**
   - Membuka endpoint JSON Django.
   - Menyalin data JSON dan memprosesnya lewat Quicktype.
   - Menempel kode Dart hasil Quicktype.
   - Membuat `lib/models/product_entry.dart` di Flutter.

5. **Mem-fetch & Menampilkan List Product di Flutter**
   - **Setup HTTP & Proxy Gambar**
     - **Django:** Menambahkan fungsi `proxy_image` di `main/views.py` dan path `proxy-image/` di `main/urls.py`.
     - **Flutter:** Menjalankan `flutter pub add http` dan memastikan `AndroidManifest.xml` memiliki permission internet.
   - **Menampilkan List Product**
     - Membuat widget kartu `ProductEntryCard` (`widgets/product_entry_card.dart`).
     - Membuat `ProductEntryListPage` (`screens/product_entry_list.dart`) dan `MyProductEntryListPage` (`screens/my_product_entry_list.dart`).
     - Menghubungkan halaman ke drawer dan menu.

6. **Menampilkan Halaman Detail Product**
   - Membuat `ProductDetailPage` (`screens/product_detail.dart`).
   - Memperbarui `ProductEntryListPage` dan `MyProductEntryListPage`.

7. **Mengintegrasi Form Flutter -> Django (Create Product)**
   - **Di Django:** Membuat view `create_product_flutter` di `main/views.py` dan menambahkan path ke URL.
   - **Di Flutter:** Memperbarui tombol form create product pada `product_form.dart`.

8. **Mengimplementasikan Fitur Logout (Django + Flutter)**
   - **Di Django:** Membuat view logout di `authentication/views.py` dan path di `authentication/urls.py`.
   - **Di Flutter:** Membuat button serta fitur logout di `LeftDrawer`.

9. **Melakukan sinkronisasi desain antara aplikasi web dengan mobile**
