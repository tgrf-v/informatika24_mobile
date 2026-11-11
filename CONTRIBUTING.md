# Panduan Kontribusi Proyek Inventaris Laboratorium

Selamat datang tim mahasiswa! Repositori ini telah disiapkan oleh **Tegar Rifa'i (Project Manager)** dengan struktur folder modular dan kerangka awal.

---

## ⚠️ Aturan Mutlak Tim
1. **Dilarang Keras Mengedit `lib/main.dart`**: File [lib/main.dart](lib/main.dart) adalah entry point tunggal dan **hanya boleh diedit oleh Tegar Rifa'i** saat integrasi rilis.
2. **Dilarang Push ke `main`**: Semua pekerjaan wajib di branch masing-masing.
3. **Format Branch**: `feat/<nama-fitur>-<nama-panggilan>` (contoh: `feat/model-barang-budi`).
4. **Pesan Commit Wajib Bahasa Indonesia**: Tulis dengan jelas (contoh: `feat(model): tambahkan model data Barang`).
5. **Commit Wajib Modular Tiap File**: 1 file / komponen logis = 1 commit. Dilarang menumpuk banyak file dalam 1 commit.
6. **Prinsip Ponytail**: Tulis kode seringkas mungkin (*lazy senior dev*), minim dependensi eksternal, dan wajib lolos `flutter analyze` dengan 0 error/warning.

---

## 🛠️ Alur Kerja Git (Git Flow)

### 1. Ambil Perubahan Terbaru dari `main`
```bash
git checkout main
git pull origin main
```

### 2. Buat Branch Baru untuk Tugasmu
```bash
git checkout -b feat/<nama-fitur>-<nama-panggilanmu>
```

### 3. Gunakan AI Coding Assistant
Buka editor (Cursor / VS Code Copilot / ChatGPT / Antigravity). AI akan otomatis membaca panduan dari file [AGENTS.md](AGENTS.md). **Copy prompt khusus tugasmu dari tabel di bawah** dan paste ke AI-mu.

### 4. Cek & Uji Kode
```bash
flutter analyze
flutter run
```
> Pastikan `flutter analyze` menghasilkan **No issues found!**

### 5. Commit & Push ke GitHub
```bash
git add <file-yang-kamu-buat>
git commit -m "feat(<komponen>): <penjelasan dalam bahasa indonesia>"
git push -u origin feat/<nama-fitur>-<nama-panggilanmu>
```

### 6. Buka Pull Request (PR) di GitHub
1. Buka repo di GitHub, klik tombol **Compare & pull request**.
2. Pastikan target base branch adalah `main`.
3. Template PR akan otomatis muncul, isi ringkasan fitur dan lampirkan screenshot aplikasi yang berjalan.
4. Beritahu PM (Tegar) untuk di-review.

---

## 📋 Pembagian 16 Tugas & Prompt Siap Pakai untuk AI

Silakan pilih **satu tugas** yang belum diambil oleh teman lain:

---

### Bagian 1: Pondasi Materi Dosen (Tahap 0 s.d. 6 & SQLite)

#### Tugas 01: Tahap 0 & Pembuatan Model Barang
> **Branch:** `feat/model-barang-<namamu>`  
> **Target File:** `lib/models/barang.dart`  
> **Prompt untuk AI:**
> *"Tolong buat model data `Barang` di file baru `lib/models/barang.dart`. Model ini memiliki properti `kode` (String), `nama` (String), dan `stok` (int). Sediakan konstruktor dengan named parameters required, method `copyWith`, `toJson()`, dan factory `fromJson()`. Jangan sentuh `lib/main.dart`. Pastikan kode ringkas sesuai prinsip Ponytail dan lolos `flutter analyze`."*

#### Tugas 02: Tahap 1 & State Awal List Inventaris
> **Branch:** `feat/state-awal-<namamu>`  
> **Target File:** `lib/screens/inventaris_screen.dart`  
> **Prompt untuk AI:**
> *"Tolong buat StatefulWidget `InventarisScreen` di file baru `lib/screens/inventaris_screen.dart`. Inisialisasi daftar in-memory awal `List<Barang>` berisi 2 barang dummy (misal Mouse dan Keyboard). Tampilkan jumlah total barang awal pada Scaffold body. Jangan sentuh `lib/main.dart`. Pastikan kode bersih dan lolos `flutter analyze`."*

#### Tugas 03: Tahap 2 & Tampilan List Item (Card Barang)
> **Branch:** `feat/listview-barang-<namamu>`  
> **Target File:** `lib/widgets/barang_card.dart` & `lib/screens/inventaris_screen.dart`  
> **Prompt untuk AI:**
> *"Tolong buat reusable widget `BarangCard` di `lib/widgets/barang_card.dart` yang menampilkan nama barang, kode, stok, dan callback tombol aksi edit & hapus. Kemudian di `lib/screens/inventaris_screen.dart`, tampilkan daftar barang menggunakan `ListView.builder` dengan widget `BarangCard` tersebut. Jangan ubah `lib/main.dart`."*

#### Tugas 04: Tahap 3 & Form Tambah Barang
> **Branch:** `feat/tambah-barang-<namamu>`  
> **Target File:** `lib/screens/form_barang_screen.dart` & `lib/screens/inventaris_screen.dart`  
> **Prompt untuk AI:**
> *"Tolong buat halaman formulir tambah barang di `lib/screens/form_barang_screen.dart` menggunakan Form dan TextFormField (kode, nama, stok) dengan validasi tidak boleh kosong dan stok harus angka >= 0. Tambahkan FloatingActionButton (+) di `lib/screens/inventaris_screen.dart` untuk membuka form tersebut dan menambahkan barang baru ke list dengan pengecekan kode unik. Jangan ubah `lib/main.dart`."*

#### Tugas 05: Tahap 4 & Logika Ubah / Edit Barang
> **Branch:** `feat/ubah-barang-<namamu>`  
> **Target File:** `lib/screens/form_barang_screen.dart` & `lib/screens/inventaris_screen.dart`  
> **Prompt untuk AI:**
> *"Tolong kembangkan `lib/screens/form_barang_screen.dart` agar bisa menerima parameter barang yang sudah ada untuk diedit (mode ubah barang dengan kode bersifat read-only). Sambungkan aksi tombol edit pada item barang di `lib/screens/inventaris_screen.dart` agar membuka form dan memperbarui data yang tersimpan. Jangan ubah `lib/main.dart`."*

#### Tugas 06: Tahap 5 & Logika Hapus Barang + Dialog Konfirmasi
> **Branch:** `feat/hapus-barang-<namamu>`  
> **Target File:** `lib/widgets/konfirmasi_hapus_dialog.dart` & `lib/screens/inventaris_screen.dart`  
> **Prompt untuk AI:**
> *"Tolong buat reusable dialog konfirmasi di `lib/widgets/konfirmasi_hapus_dialog.dart`. Hubungkan tombol hapus pada kartu barang di `lib/screens/inventaris_screen.dart` agar memunculkan konfirmasi dialog sebelum menghapus item dari list. Tampilkan SnackBar feedback setelah barang berhasil dihapus. Jangan ubah `lib/main.dart`."*

#### Tugas 07: Tahap 6 & Penyimpanan SharedPreferences
> **Branch:** `feat/shared-preferences-<namamu>`  
> **Target File:** `lib/services/pref_service.dart`  
> **Prompt untuk AI:**
> *"Tolong buat layer penyimpanan lokal menggunakan package `shared_preferences` di `lib/services/pref_service.dart`. Buat method async untuk menyimpan daftar barang ke JSON string dan memuatnya kembali saat aplikasi dibuka. Sambungkan service ini ke `lib/screens/inventaris_screen.dart`. Jangan ubah `lib/main.dart`."*

#### Tugas 08: Referensi Native & Penyimpanan SQLite
> **Branch:** `feat/sqlite-storage-<namamu>`  
> **Target File:** `lib/services/sqlite_service.dart`  
> **Prompt untuk AI:**
> *"Tolong buat service database SQLite menggunakan package `sqflite` dan `path` di `lib/services/sqlite_service.dart` berdasarkan materi referensi dosen. Buat tabel `barang` dan method lengkap CRUD: baca, tambah, ubah, dan hapus. Jangan ubah `lib/main.dart`."*

---

### Bagian 2: Fitur Tambahan & Ekstensi Modular

#### Tugas 09: Komponen Pencarian (Search Bar)
> **Branch:** `feat/search-bar-<namamu>`  
> **Target File:** `lib/widgets/search_bar_widget.dart`  
> **Prompt untuk AI:**
> *"Tolong buat reusable widget `SearchBarWidget` di `lib/widgets/search_bar_widget.dart` dengan icon search dan tombol clear. Hubungkan ke `lib/screens/inventaris_screen.dart` agar daftar barang dapat difilter secara real-time berdasarkan pencarian nama atau kode barang secara case-insensitive."*

#### Tugas 10: Komponen Filter Status Stok
> **Branch:** `feat/filter-stok-<namamu>`  
> **Target File:** `lib/widgets/filter_stok_chips.dart`  
> **Prompt untuk AI:**
> *"Tolong buat reusable widget `FilterStokChips` di `lib/widgets/filter_stok_chips.dart` menggunakan FilterChip/ChoiceChip dengan pilihan: 'Semua', 'Stok Kritis (<= 2)', dan 'Stok Tersedia (> 2)'. Pasang di `lib/screens/inventaris_screen.dart` untuk memfilter data yang tampil."*

#### Tugas 11: Fitur Pengurutan Data (Sorting)
> **Branch:** `feat/sort-barang-<namamu>`  
> **Target File:** `lib/screens/inventaris_screen.dart`  
> **Prompt untuk AI:**
> *"Tolong tambahkan menu pengurutan data di AppBar `lib/screens/inventaris_screen.dart` menggunakan PopupMenuButton dengan opsi: 'Nama (A-Z)', 'Nama (Z-A)', 'Stok Terbanyak', dan 'Stok Tersedikit'. Pastikan daftar barang otomatis tersortir sesuai pilihan pengguna."*

#### Tugas 12: Halaman Rincian Lengkap Barang
> **Branch:** `feat/detail-barang-<namamu>`  
> **Target File:** `lib/screens/detail_barang_screen.dart`  
> **Prompt untuk AI:**
> *"Tolong buat halaman detail barang di `lib/screens/detail_barang_screen.dart`. Ketika kartu barang ditekan, buka halaman ini untuk menampilkan rincian kode, nama, jumlah stok, status ketersediaan, serta tombol shortcut untuk edit atau hapus. Jangan ubah `lib/main.dart`."*

#### Tugas 13: Konfigurasi Tema Terang & Gelap (Dark Mode)
> **Branch:** `feat/dark-theme-<namamu>`  
> **Target File:** `lib/theme/app_theme.dart`  
> **Prompt untuk AI:**
> *"Tolong buat konfigurasi tema Light Mode dan Dark Mode berbasis Material 3 di `lib/theme/app_theme.dart`. Sediakan tombol switch/toggle tema di AppBar `lib/screens/inventaris_screen.dart` untuk mengganti mode tampilan. Jangan ubah `lib/main.dart`."*

#### Tugas 14: Widget Ringkasan Statistik Stok (Dashboard Mini)
> **Branch:** `feat/statistik-stok-<namamu>`  
> **Target File:** `lib/widgets/ringkasan_stok_widget.dart`  
> **Prompt untuk AI:**
> *"Tolong buat reusable widget `RingkasanStokWidget` di `lib/widgets/ringkasan_stok_widget.dart`. Tampilkan baris kartu mini yang merangkum: Total Jenis Barang, Total Unit Fisik, dan Jumlah Barang Kritis (stok <= 2). Hubungkan dengan data di `lib/screens/inventaris_screen.dart`."*

#### Tugas 15: Validasi Input & Pemformat Teks Terpusat
> **Branch:** `feat/validators-formatters-<namamu>`  
> **Target File:** `lib/utils/validators.dart` & `lib/utils/formatters.dart`  
> **Prompt untuk AI:**
> *"Tolong buat fungsi validasi input di `lib/utils/validators.dart` (validasi kode barang min 3 karakter alfanumerik, nama min 3 huruf, stok angka positif) dan helper pemformatan di `lib/utils/formatters.dart`. Hubungkan validator ini ke `lib/screens/form_barang_screen.dart`."*

#### Tugas 16: Pengujian Unit Testing & Dokumentasi README
> **Branch:** `feat/test-dan-docs-<namamu>`  
> **Target File:** `test/models/barang_test.dart` & `README.md`  
> **Prompt untuk AI:**
> *"Tolong buat unit test pengujian model `Barang` di `test/models/barang_test.dart` yang menguji serialisasi JSON dan method copyWith. Lalu perbarui `README.md` utama dengan dokumentasi lengkap alur aplikasi, screenshot demo, dan daftar kontributor tim. Pastikan `flutter test` lulus 100%."*
