# Panduan Kontribusi Proyek Inventaris Laboratorium

Selamat datang! Dokumen ini adalah panduan praktis untuk seluruh anggota kelas agar proses pengerjaan tugas bersama berjalan lancar, tanpa bentrok kode (merge conflict), dan dinilai rapi oleh dosen.

---

## 🛠️ Langkah Cepat Mulai (Git Flow)

### 1. Sinkronisasi Repo Awal
Buka terminal di folder proyek ini:
```bash
git checkout main
git pull origin main
```

### 2. Buat Branch Baru untuk Tugasmu
Jangan pernah ngoding langsung di branch `main`. Buat branch baru:
```bash
git checkout -b feat/<nama-fitur>-<nama-panggilanmu>
# Contoh: git checkout -b feat/search-bar-budi
```

### 3. Jalankan / Gunakan AI Assistant
Jika kamu menggunakan AI Assistant (Cursor, Copilot, ChatGPT, Antigravity, dll), **copy prompt khusus tugasmu dari tabel di bawah** dan paste ke AI. AI akan otomatis membaca aturan di file `AGENTS.md` sehingga kodenya langsung terstruktur rapi.

### 4. Uji Kode
Pastikan tidak ada error sintaks:
```bash
flutter analyze
flutter run
```

### 5. Simpan (Commit) & Unggah (Push)
```bash
git add .
git commit -m "feat: implementasi fitur <nama-fitur>"
git push -u origin feat/<nama-fitur>-<nama-panggilanmu>
```

### 6. Buka Pull Request (PR) di GitHub
1. Buka halaman GitHub repositori ini.
2. Klik tombol hijau **Compare & pull request**.
3. Pastikan base branch adalah `main`.
4. Beri judul PR: `[FEAT] <Nama Fitur>`
5. Di deskripsi PR, jelaskan singkat apa yang dibuat dan lampirkan screenshot tampilan aplikasi.
6. Beritahu Project Manager (PM) untuk di-review.

---

## 📋 Daftar Tugas & Prompt Siap Pakai untuk AI

Pilih **satu** nomor tugas di bawah ini yang belum diambil teman lain:

---

### Track A: Penyimpanan Data & Layanan

#### Tugas 01: Service SharedPreferences (Tahap 6)
> **Branch:** `feat/shared-preferences-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong implementasikan penyimpanan lokal SharedPreferences untuk aplikasi ini sesuai referensi Tahap 6. Buat file baru di `lib/services/storage_service.dart`. Buat class `StorageService` yang memiliki fungsi async `muatBarang()` dan `simpanBarang(List<Barang>)` menggunakan package `shared_preferences`. Sambungkan service ini ke `lib/screens/inventaris_screen.dart` agar data tersimpan permanen saat aplikasi ditutup dan dibuka kembali. Pastikan kode bersih dan lolos `flutter analyze`."*

#### Tugas 02: Service SQLite Native (Referensi Native)
> **Branch:** `feat/sqlite-storage-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong buatkan implementasi database lokal SQLite menggunakan package `sqflite` dan `path` di file terpisah `lib/services/sqlite_service.dart`. Buat method CRUD lengkap (baca, tambah, ubah, hapus). Sambungkan sebagai opsi data provider di aplikasi tanpa merusak struktur modular yang sudah ada di `lib/models/barang.dart`. Pastikan kode bersih dan lolos `flutter analyze`."*

---

### Track B: Komponen UI & Visual

#### Tugas 03: Desain Modern Card Barang & Badge Stok
> **Branch:** `feat/ui-barang-card-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong percantik tampilan komponen `lib/widgets/barang_card.dart`. Tambahkan badge warna status stok: jika stok <= 2 beri badge merah 'Stok Kritis', jika 3-5 beri badge oranye 'Stok Menipis', jika > 5 beri badge hijau 'Aman'. Tambahkan icon representatif di sebelah kiri nama barang. Jangan ubah signature callback onEdit dan onDelete agar tidak merusak halaman utama."*

#### Tugas 04: Validasi Form & Tampilan Form Modern
> **Branch:** `feat/form-validation-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong tingkatkan validasi dan tampilan di `lib/screens/form_barang_screen.dart`. Tambahkan validasi: panjang kode minimal 3 karakter (hanya huruf & angka), nama barang minimal 3 huruf, dan stok harus bilangan bulat positif. Berikan ikon pembantu pada InputDecoration dan buat tombol simpan lebih menarik dengan icon save."*

#### Tugas 05: Komponen Empty State yang Menarik
> **Branch:** `feat/empty-state-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong buatkan reusable widget `EmptyStateWidget` di file baru `lib/widgets/empty_state_widget.dart`. Tampilkan icon kotak/inventaris besar yang estetik, teks pemberitahuan bahwa belum ada data, dan tombol aksi 'Tambah Barang Pertama' yang memicu callback ke form tambah. Pasang widget ini di `lib/screens/inventaris_screen.dart` ketika list barang kosong."*

#### Tugas 06: Dialog Konfirmasi & Feedback Notifikasi Interaktif
> **Branch:** `feat/dialog-feedback-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong buat reusable dialog konfirmasi hapus di `lib/widgets/konfirmasi_hapus_dialog.dart` dengan desain AlertDialog Material 3 yang rapi (menampilkan nama barang dan peringatan bahwa tindakan tidak dapat dibatalkan). Tambahkan juga fungsi SnackBar kustom dengan opsi 'Undo / Batalkan Hapus' jika barang terhapus di `lib/screens/inventaris_screen.dart`."*

---

### Track C: Fitur Fungsional CRUD

#### Tugas 07: Fitur Pencarian (Search Bar)
> **Branch:** `feat/search-bar-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong buatkan komponen search bar di file baru `lib/widgets/search_bar_widget.dart`. Sambungkan ke `lib/screens/inventaris_screen.dart` sehingga pengguna bisa mencari barang secara real-time berdasarkan kecocokan nama barang atau kode barang (case-insensitive)."*

#### Tugas 08: Fitur Filter Kategori / Kondisi Stok
> **Branch:** `feat/filter-stok-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong buatkan filter menggunakan FilterChip di file baru `lib/widgets/filter_stok_chips.dart`. Sediakan pilihan filter: 'Semua', 'Stok Kritis (<= 2)', dan 'Stok Tersedia (> 2)'. Hubungkan filter ini ke list barang di `lib/screens/inventaris_screen.dart`."*

#### Tugas 09: Fitur Pengurutan (Sorting) Data
> **Branch:** `feat/sort-barang-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong tambahkan fitur urutkan data (Sort) di `lib/screens/inventaris_screen.dart`. Buat tombol PopupMenuButton di AppBar dengan opsi pengurutan: 'Nama (A-Z)', 'Nama (Z-A)', 'Stok Terbanyak', dan 'Stok Tersedikit'. Pastikan daftar barang otomatis tersortir sesuai pilihan pengguna."*

#### Tugas 10: Halaman Rincian / Detail Barang
> **Branch:** `feat/detail-barang-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong buat halaman detail rincian barang di file baru `lib/screens/detail_barang_screen.dart`. Ketika kartu barang di `lib/widgets/barang_card.dart` ditekan (onTap), buka halaman ini. Tampilkan informasi lengkap kode, nama, jumlah stok, estimasi status ketersediaan, serta tombol shortcut untuk edit atau hapus barang tersebut."*

---

### Track D: Fitur Ekstra & Pengalaman Pengguna

#### Tugas 11: Dark Mode / Tema Gelap & Terang
> **Branch:** `feat/dark-theme-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong tambahkan dukungan Dark Mode dan Light Mode pada aplikasi. Buat tema di file baru `lib/theme/app_theme.dart` dengan warna Material 3 yang serasi. Tambahkan tombol toggle tema (icon matahari/bulan) di AppBar `lib/screens/inventaris_screen.dart` yang dapat mengubah mode tampilan aplikasi secara dinamis."*

#### Tugas 12: Ringkasan Statistik Inventaris (Dashboard Card)
> **Branch:** `feat/statistik-card-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong buatkan widget ringkasan statistik inventaris di file baru `lib/widgets/ringkasan_stok_widget.dart`. Tampilkan baris kartu mini di atas list barang yang merangkum: Total Jenis Barang, Total Item Fisik (jumlah seluruh stok), dan Jumlah Barang Kritis. Hubungkan dengan data di `lib/screens/inventaris_screen.dart`."*

#### Tugas 13: Fitur Bagikan / Salin Data Laporan (Share / Export)
> **Branch:** `feat/export-laporan-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong tambahkan fitur salin/ekspor laporan inventaris ke clipboard di `lib/screens/inventaris_screen.dart`. Tambahkan tombol di AppBar yang akan merangkum seluruh daftar barang ke dalam format teks rapi (contoh: 'Laporan Inventaris Lab - [Tanggal]...'), lalu menyalinnya ke clipboard sistem (menggunakan `Clipboard.setData`) dan memunculkan notifikasi berhasil."*

#### Tugas 14: Fitur Penyesuaian Cepat Stok (+/- Cepat)
> **Branch:** `feat/quick-stock-adjust-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong tambahkan tombol aksi cepat tambah (+1) dan kurang (-1) stok langsung di kartu barang `lib/widgets/barang_card.dart`. Ketika tombol ditekan, perbarui jumlah stok barang tersebut dengan validasi bahwa stok tidak boleh berkurang di bawah 0."*

---

### Track E: Testing & Dokumentasi

#### Tugas 15: Unit Testing & Widget Testing
> **Branch:** `feat/testing-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong buatkan pengujian komprehensif di folder `test/`:
> 1. `test/models/barang_test.dart`: uji konstruktor `Barang`, serialisasi `toJson()`, deserialisasi `fromJson()`, dan metode `copyWith()`.
> 2. `test/widgets/barang_card_test.dart`: uji bahwa `BarangCard` menampilkan nama, kode, dan memicu callback edit/hapus saat ditekan.
> Pastikan seluruh tes lulus saat dijalankan dengan `flutter test`."*

#### Tugas 16: Dokumentasi Lengkap README & Panduan Demo
> **Branch:** `feat/docs-readme-<namamu>`  
> **Prompt untuk AI:**
> *"Tolong buatkan file `README.md` utama yang profesional dan menarik untuk proyek ini:
> 1. Judul aplikasi dan deskripsi singkat.
> 2. Daftar fitur utama (CRUD lengkap, validasi, modular).
> 3. Panduan instalasi dan menjalankan aplikasi (prasyarat Flutter SDK).
> 4. Penjelasan struktur folder modular.
> 5. Bagian daftar kontributor tim kelas.
> Pastikan format Markdown sangat rapi dan mudah dibaca."*
