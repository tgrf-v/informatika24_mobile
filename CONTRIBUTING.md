# Panduan Kontribusi Proyek Inventaris Laboratorium

Selamat datang! Dokumen ini adalah panduan praktis untuk seluruh anggota kelas agar proses pengerjaan tugas bersama berjalan lancar, tanpa bentrok kode (merge conflict), dan dinilai rapi oleh dosen.

---

## ⚠️ Aturan Penting Tim
1. **Dilarang Keras Edit `lib/main.dart`**: File ini hanya boleh diedit oleh **Tegar Rifa'i** selaku Project Manager (PM) untuk rilis integrasi.
2. **Dilarang Push ke `main`**: Semua pekerjaan wajib di branch masing-masing (`feat/...`).
3. **Pesan Commit Wajib Bahasa Indonesia**: Gunakan format `feat(komponen): penjelasan singkat` atau `fix(komponen): perbaikan`.
4. **Commit Modular Tiap File**: Setiap file atau komponen logis yang selesai wajib di-commit tersendiri (jangan menumpuk banyak file dalam 1 commit).
5. **Prinsip Ponytail**: Tulis kode seringkas dan serapi mungkin tanpa dependensi berlebih.

---

## 🛠️ Langkah Cepat Mulai (Git Flow)

### 1. Sinkronisasi Repo Awal
Buka terminal di folder proyek ini:
```bash
git checkout main
git pull origin main
```

### 2. Buat Branch Baru untuk Tugasmu
```bash
git checkout -b feat/<nama-fitur>-<nama-panggilanmu>
# Contoh: git checkout -b feat/search-bar-budi
```

### 3. Gunakan AI Coding Assistant
Buka editor (Cursor / VS Code Copilot / dsb). AI akan otomatis membaca panduan dari file [AGENTS.md](file:///d:/Proyek/Mobile/informatika24_mobile/AGENTS.md). **Copy prompt khusus tugasmu dari tabel di bawah** dan paste ke AI-mu.

### 4. Uji Kode
```bash
flutter analyze
flutter run
```
> Pastikan `flutter analyze` menghasilkan **No issues found!**

### 5. Simpan (Commit) & Unggah (Push)
Gunakan Bahasa Indonesia pada pesan commit:
```bash
git add <file-yang-diubah>
git commit -m "feat(<fitur>): <penjelasan dalam bahasa indonesia>"
git push -u origin feat/<nama-fitur>-<nama-panggilanmu>
```

### 6. Buka Pull Request (PR) di GitHub
1. Buka repo di GitHub.
2. Klik **Compare & pull request** ke branch `main`.
3. Isi form template PR yang otomatis muncul (deskripsi & screenshot).
4. Beritahu PM (Tegar) untuk di-review.

---

## 📋 Daftar Tugas & Prompt Siap Pakai untuk AI

Pilih **satu** nomor tugas di bawah ini yang belum diambil teman lain:

---

### Track A: Penyimpanan Data & Layanan

#### Tugas 01: Service SharedPreferences (Tahap 6)
> **Branch:** `feat/shared-preferences-<namamu>`  
> **File Sasaran:** `lib/services/pref_service.dart`  
> **Prompt untuk AI:**
> *"Tolong lengkapi implementasi penyimpanan SharedPreferences pada file `lib/services/pref_service.dart` sesuai materi Tahap 6. Gunakan package `shared_preferences` untuk menyimpan dan memuat data `Barang` ke JSON string. Jangan ubah `lib/main.dart`. Pastikan kode ringkas sesuai prinsip Ponytail dan lolos `flutter analyze`."*

#### Tugas 02: Service SQLite Native (Referensi Native)
> **Branch:** `feat/sqlite-storage-<namamu>`  
> **File Sasaran:** `lib/services/sqlite_service.dart`  
> **Prompt untuk AI:**
> *"Tolong lengkapi implementasi database SQLite pada file `lib/services/sqlite_service.dart` sesuai materi referensi native dosen menggunakan package `sqflite` dan `path`. Buat method CRUD lengkap (baca, tambah, ubah, hapus) berbasis SQLite. Jangan ubah `lib/main.dart`. Pastikan kode ringkas sesuai prinsip Ponytail dan lolos `flutter analyze`."*

---

### Track B: Komponen UI & Visual

#### Tugas 03: Desain Modern Card Barang & Badge Stok
> **Branch:** `feat/ui-barang-card-<namamu>`  
> **File Sasaran:** `lib/widgets/barang_card.dart`  
> **Prompt untuk AI:**
> *"Tolong percantik tampilan komponen `lib/widgets/barang_card.dart`. Tambahkan badge warna status stok: jika stok <= 2 beri badge merah 'Stok Kritis', jika 3-5 beri badge oranye 'Stok Menipis', jika > 5 beri badge hijau 'Aman'. Tambahkan icon representatif di sebelah kiri nama barang. Jangan ubah signature callback onEdit dan onDelete agar tidak merusak halaman utama."*

#### Tugas 04: Validasi Form & Tampilan Form Modern
> **Branch:** `feat/form-validation-<namamu>`  
> **File Sasaran:** `lib/screens/form_barang_screen.dart`  
> **Prompt untuk AI:**
> *"Tolong tingkatkan validasi dan tampilan di `lib/screens/form_barang_screen.dart`. Gunakan validator dari `lib/utils/validators.dart`. Tambahkan validasi: panjang kode minimal 3 karakter (hanya huruf & angka), nama barang minimal 3 huruf, dan stok harus bilangan bulat positif. Berikan ikon pembantu pada InputDecoration dan buat tombol simpan lebih menarik."*

#### Tugas 05: Komponen Empty State yang Menarik
> **Branch:** `feat/empty-state-<namamu>`  
> **File Sasaran:** `lib/widgets/empty_state_widget.dart`  
> **Prompt untuk AI:**
> *"Tolong kembangkan reusable widget `EmptyStateWidget` di `lib/widgets/empty_state_widget.dart`. Tampilkan visual ikon inventaris yang modern, teks informasi bahwa data belum tersedia, dan tombol aksi 'Tambah Barang Pertama' yang memicu callback ke form tambah."*

#### Tugas 06: Dialog Konfirmasi & Feedback Interaktif
> **Branch:** `feat/dialog-feedback-<namamu>`  
> **File Sasaran:** `lib/widgets/konfirmasi_hapus_dialog.dart`  
> **Prompt untuk AI:**
> *"Tolong sempurnakan reusable dialog konfirmasi di `lib/widgets/konfirmasi_hapus_dialog.dart` dengan gaya Material 3 yang elegan (tampilkan nama barang dan peringatan bahwa aksi bersifat permanen). Sediakan helper static method agar mudah dipanggil dari mana saja."*

---

### Track C: Fitur Fungsional CRUD

#### Tugas 07: Fitur Pencarian (Search Bar)
> **Branch:** `feat/search-bar-<namamu>`  
> **File Sasaran:** `lib/widgets/search_bar_widget.dart` & `lib/screens/inventaris_screen.dart`  
> **Prompt untuk AI:**
> *"Tolong sambungkan `lib/widgets/search_bar_widget.dart` ke halaman `lib/screens/inventaris_screen.dart`. Implementasikan pencarian real-time sehingga daftar barang otomatis terfilter berdasarkan nama atau kode barang yang diketik pengguna secara case-insensitive."*

#### Tugas 08: Fitur Filter Kondisi Stok
> **Branch:** `feat/filter-stok-<namamu>`  
> **File Sasaran:** `lib/widgets/filter_stok_chips.dart` & `lib/screens/inventaris_screen.dart`  
> **Prompt untuk AI:**
> *"Tolong pasang widget filter `lib/widgets/filter_stok_chips.dart` di halaman `lib/screens/inventaris_screen.dart`. Hubungkan filter tersebut agar daftar barang yang tampil dapat difilter berdasarkan: Semua, Stok Kritis (<= 2), dan Stok Tersedia (> 2)."*

#### Tugas 09: Fitur Pengurutan (Sorting) Data
> **Branch:** `feat/sort-barang-<namamu>`  
> **File Sasaran:** `lib/screens/inventaris_screen.dart`  
> **Prompt untuk AI:**
> *"Tolong tambahkan fitur urutkan data (Sort) di `lib/screens/inventaris_screen.dart`. Tambahkan PopupMenuButton di AppBar dengan pilihan: 'Nama (A-Z)', 'Nama (Z-A)', 'Stok Terbanyak', dan 'Stok Tersedikit'. Pastikan daftar barang langsung terurut sesuai pilihan."*

#### Tugas 10: Halaman Rincian / Detail Barang
> **Branch:** `feat/detail-barang-<namamu>`  
> **File Sasaran:** `lib/screens/detail_barang_screen.dart` & `lib/widgets/barang_card.dart`  
> **Prompt untuk AI:**
> *"Tolong sempurnakan halaman rincian barang di `lib/screens/detail_barang_screen.dart`. Tambahkan navigasi dari `lib/widgets/barang_card.dart` ketika kartu barang ditekan (onTap). Tampilkan kartu info spesifikasi, status stok, dan tombol pintas ubah barang."*

---

### Track D: Fitur Ekstra & Pengalaman Pengguna

#### Tugas 11: Dark Mode / Tema Gelap & Terang
> **Branch:** `feat/dark-theme-<namamu>`  
> **File Sasaran:** `lib/theme/app_theme.dart` & `lib/screens/inventaris_screen.dart`  
> **Prompt untuk AI:**
> *"Tolong lengkapi konfigurasi tema di `lib/theme/app_theme.dart`. Tambahkan tombol toggle tema (ikon matahari/bulan) di AppBar `lib/screens/inventaris_screen.dart` yang dapat mengubah mode terang/gelap secara instan. Jangan ubah file `lib/main.dart`."*

#### Tugas 12: Ringkasan Statistik Inventaris (Dashboard Card)
> **Branch:** `feat/statistik-card-<namamu>`  
> **File Sasaran:** `lib/screens/statistik_screen.dart` & `lib/widgets/ringkasan_stok_widget.dart`  
> **Prompt untuk AI:**
> *"Tolong kembangkan halaman `lib/screens/statistik_screen.dart` yang menggunakan `lib/widgets/ringkasan_stok_widget.dart`. Tampilkan metrik ringkas: Total Jenis Barang, Total Unit Fisik, dan Total Barang Kritis. Berikan tombol di AppBar halaman utama untuk membuka layar statistik ini."*

#### Tugas 13: Fitur Bagikan / Salin Data Laporan (Share / Export)
> **Branch:** `feat/export-laporan-<namamu>`  
> **File Sasaran:** `lib/screens/inventaris_screen.dart` & `lib/utils/formatters.dart`  
> **Prompt untuk AI:**
> *"Tolong tambahkan fitur salin laporan inventaris ke clipboard pada `lib/screens/inventaris_screen.dart`. Gunakan helper format dari `lib/utils/formatters.dart`. Tambahkan ikon bagikan di AppBar yang ketika ditekan menyalin ringkasan seluruh daftar barang ke clipboard sistem (`Clipboard.setData`) dan memunculkan notifikasi SnackBar berhasil."*

#### Tugas 14: Fitur Penyesuaian Cepat Stok (+/- Cepat)
> **Branch:** `feat/quick-stock-adjust-<namamu>`  
> **File Sasaran:** `lib/widgets/barang_card.dart` & `lib/screens/inventaris_screen.dart`  
> **Prompt untuk AI:**
> *"Tolong tambahkan tombol aksi cepat tambah (+1) dan kurang (-1) stok langsung pada kartu barang di `lib/widgets/barang_card.dart`. Pastikan stok tidak bisa dikurangi di bawah 0 dan perubahan langsung tercermin pada state list barang."*

---

### Track E: Testing & Dokumentasi

#### Tugas 15: Unit Testing & Widget Testing
> **Branch:** `feat/testing-<namamu>`  
> **File Sasaran:** `test/models/barang_test.dart` & `test/utils/validators_test.dart`  
> **Prompt untuk AI:**
> *"Tolong buat pengujian unit test lengkap di `test/models/barang_test.dart` (menguji serialisasi JSON dan copyWith) serta `test/utils/validators_test.dart` (menguji validasi kode, nama, dan stok). Pastikan semua tes lulus saat dijalankan dengan `flutter test`."*

#### Tugas 16: Dokumentasi Lengkap README & Panduan Demo
> **Branch:** `feat/docs-readme-<namamu>`  
> **File Sasaran:** `README.md`  
> **Prompt untuk AI:**
> *"Tolong perbarui file `README.md` utama dengan dokumentasi profesional: judul aplikasi, diagram arsitektur folder modular, ringkasan fitur CRUD, panduan instalasi dan menjalankan aplikasi, serta daftar kontributor tim kelas."*
