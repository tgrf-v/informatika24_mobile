# 🖥️ Informatika 24 Mobile — Sistem Inventaris Laboratorium

Aplikasi Manajemen Inventaris Laboratorium Komputer berbasis **Flutter** dan **Material 3** yang dirancang modular, responsif, dan mudah digunakan untuk pengelolaan aset laboratorium secara efisien.

---

## 📱 Antarmuka Aplikasi (Mobile Showcase)

<p align="center">
  <img src="docs/screenshots/tampilan_utama.png" width="320" alt="Dashboard Utama Inventaris" />
  &emsp;&emsp;
  <img src="docs/screenshots/form_tambah_barang.png" width="320" alt="Formulir Tambah Barang" />
</p>

<p align="center">
  <em>Kiri: Katalog Inventaris & Indikator Stok &emsp;|&emsp; Kanan: Formulir Tambah Barang & Generator Kode</em>
</p>

---

### 1. Dashboard Utama (Katalog Inventaris)
Tampilan utama menyajikan daftar seluruh barang inventaris lengkap dengan kode aset, kategori jenis, stok fisik, estimasi harga satuan, serta status ketersediaan barang.

> **Fitur pada Dashboard Utama:**
> - **Pencarian Instan:** Filter barang secara langsung berdasarkan nama, kode barang (`BRGxxx`), atau kategori jenis melalui bilah pencarian atas.
> - **Ringkasan Inventaris:** Menampilkan total jenis barang terdaftar dan akumulasi unit fisik secara otomatis (*real-time*).
> - **Badge Stok Kritis:** Tanda peringatan merah otomatis (*Stok Kritis*) untuk barang dengan jumlah stok $\le 2$ unit agar memudahkan pengadaan ulang.
> - **Aksi Cepat:** Tombol ubah data (edit) dan hapus barang langsung dari setiap kartu item.

---

### 2. Formulir Tambah & Edit Barang
Formulir input barang yang dilengkapi dengan generator kode otomatis serta validasi data terpusat.

> **Fitur pada Formulir Barang:**
> - **Kode Otomatis:** Sistem secara pintar mendeteksi ID terakhir dan membuat kode baru (contoh: `BRG018`) agar tidak terjadi duplikasi.
> - **Pilihan Kategori Modular:** Dropdown kategori standar lab (Periferal, Layar, Komputer, Presentasi, Kabel, Jaringan, Daya, Lainnya).
> - **Validasi Input Terpusat:** Memastikan kode unik, nama valid (minimal 3 karakter), dan stok bernilai non-negatif.
> - **Notifikasi Status:** Banner notifikasi animasi di bagian atas (*Top Banner*) yang memberikan umpan balik langsung setelah data berhasil disimpan atau diperbarui.

---

## ✨ Fitur Unggulan

- 📦 **Manajemen Inventaris Penuh (CRUD):** Tambah barang baru, tinjau spesifikasi, ubah informasi, dan hapus barang dengan dialog konfirmasi aman.
- 🔍 **Pencarian & Penyaringan Real-Time:** Filter dinamis tanpa jeda untuk mempercepat pencarian peralatan di lab.
- ⚠️ **Sistem Deteksi Stok Kritis:** Pengingat otomatis untuk inventaris yang hampir habis.
- 💾 **Penyimpanan Lokal Persisten:** Terintegrasi dengan `SharedPreferences` (`PrefService`) sehingga perubahan data tetap tersimpan saat aplikasi ditutup.
- 🎨 **Material 3 Modern & Responsif:** Mengikuti standar desain terbaru Google dengan palet warna ramah mata, kartu melengkung (*rounded cards*), dan transisi halus di Web, Windows, maupun Android.
- 🧪 **Pengujian Otomatis:** Didukung unit test dan widget test komprehensif (`flutter test`) dengan 0 error analisis (`flutter analyze`).

---

## 📁 Struktur Folder Proyek

Arsitektur aplikasi dibangun dengan pendekatan modular terpisah:

```text
lib/
├── constants/         # Nilai konstan terpusat (warna, teks, batasan stok)
├── models/            # Struktur data (Barang, Kategori, Riwayat)
├── services/          # Layer penyimpanan data lokal (PrefService / SharedPreferences)
├── theme/             # Konfigurasi visual Material 3 (AppTheme)
├── utils/             # Helper validasi form & pemformatan teks/angka
├── widgets/           # Komponen UI independen (BarangCard, SearchBar, TopBanner, EmptyState)
├── screens/           # Halaman utama aplikasi (InventarisScreen, FormBarangScreen)
└── main.dart          # Entry point tunggal aplikasi
```

---

## 🚀 Panduan Menjalankan Aplikasi

### Prasyarat
- Flutter SDK (versi $\ge$ 3.24)
- Google Chrome (untuk Web) atau C++ Desktop Development tools (untuk Windows)

### Langkah-langkah
```bash
# 1. Clone repositori
git clone https://github.com/tgrf-v/informatika24_mobile.git
cd informatika24_mobile

# 2. Pasang dependensi
flutter pub get

# 3. Jalankan verifikasi kode & pengujian
flutter analyze
flutter test

# 4. Jalankan aplikasi di browser Chrome
flutter run -d chrome

# Atau jalankan aplikasi di Windows Desktop
flutter run -d windows
```

---

## 🤝 Panduan Kontribusi & Tim

Bagi seluruh anggota tim mahasiswa yang ingin berkontribusi:
1. Baca pedoman kontribusi dan daftar tugas di [CONTRIBUTING.md](CONTRIBUTING.md).
2. Patuhi aturan arsitektur, konvensi penamaan branch, dan larangan edit `lib/main.dart` di [AGENTS.md](AGENTS.md).
3. Buat Pull Request menggunakan template standar di [.github/pull_request_template.md](.github/pull_request_template.md).
