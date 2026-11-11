# AI Agent & Contributor Guidelines: informatika24_mobile

Dokumen ini adalah aturan mutlak (ground truth) untuk seluruh kontributor mahasiswa dan AI Coding Assistant (Cursor, GitHub Copilot, Antigravity, Claude Code, ChatGPT, dsb) yang bekerja pada repositori ini.

---

## 1. Aturan Mutlak Hak Akses & File `main.dart`
> [!CAUTION]
> **DILARANG KERAS MENGEDIT FILE `lib/main.dart`!**
> File [lib/main.dart](file:///d:/Proyek/Mobile/informatika24_mobile/lib/main.dart) adalah entry point tunggal dan **HANYA BOLEH DIEDIT OLEH TEGAR RIFA'I (PROJECT MANAGER)** saat melakukan integrasi rilis. Seluruh pekerjaan fitur, widget, screen, dan service **wajib** dibuat di file terpisah.

---

## 2. Aturan Git, Branching, & Larangan Push ke `main`
1. **Dilarang Keras Push ke `main`:**
   Semua pekerjaan wajib dilakukan di branch masing-masing. Push langsung ke branch `main` dilarang.
2. **Format Penamaan Branch:**
   Format: `feat/<nama-fitur>-<nama-panggilan>`  
   *Contoh:* `feat/search-bar-budi`, `feat/sqlite-andi`, `feat/dark-theme-siti`.
3. **Commit Wajib Berbahasa Indonesia:**
   Pesan commit **WAJIB** ditulis dalam Bahasa Indonesia yang jelas dan spesifik.  
   *Contoh Benar:*
   - `feat(widget): tambahkan komponen SearchBarWidget`
   - `fix(validasi): perbaiki pengecekan angka negatif pada stok`
   - `docs: perbarui panduan kontributor`  
   *Contoh Salah:* `update code`, `fix bug`, `feat: add new feature`.
4. **Commit Wajib Modular Tiap File:**
   Setiap perubahan file atau komponen logis **wajib di-commit terpisah** (1 fungsi/file = 1 commit). Dilarang keras menumpuk banyak file dalam satu commit besar.

---

## 3. Penerapan Prinsip Ponytail (Lazy Senior Dev)
1. **Minimalis & Tepat Sasaran:** Selesaikan masalah dengan kode paling ringkas dan efisien (*the best code is the code never written*).
2. **Anti-Bloat & Anti Over-Engineering:** Dilarang membuat wrapper/abstraksi berlebihan atau kelas perantara yang tidak diminta.
3. **Maksimalkan Fitur Native:** Gunakan kemampuan bawaan Flutter dan Material 3 sebelum memutuskan menambah package pihak ketiga (`pub.dev`).
4. **Wajib Analisis Bebas Error:** Setiap baris kode yang ditulis **wajib lolos `flutter analyze`** dengan 0 error dan 0 warning.

---

## 4. Arsitektur Folder & Peta File Proyek

```text
lib/
├── constants/           # Nilai konstan & string terpusat
│   ├── app_colors.dart      # Palet warna aplikasi
│   ├── app_constants.dart   # Ambang batas stok kritis & kunci preferensi
│   └── app_strings.dart     # Label & teks antarmuka
├── models/              # Struktur data objek
│   ├── barang.dart          # Model utama barang (kode, nama, stok, JSON parser)
│   ├── kategori.dart        # Model kategori barang
│   └── riwayat_transaksi.dart# Model log mutasi stok masuk/keluar
├── services/            # Layer penyimpanan & koneksi data
│   ├── storage_service.dart # Antarmuka (interface) kontrak penyimpanan
│   ├── pref_service.dart    # Implementasi SharedPreferences (Tahap 6)
│   └── sqlite_service.dart  # Implementasi SQLite Native (Referensi)
├── theme/               # Konfigurasi visual & tema
│   └── app_theme.dart       # Pengaturan Light Mode & Dark Mode Material 3
├── utils/               # Fungsi pembantu murni (pure helpers)
│   ├── formatters.dart      # Helper pemformatan teks & angka
│   └── validators.dart      # Logika validasi input form (kode, nama, stok)
├── widgets/             # Reusable UI components kecil & mandiri
│   ├── barang_card.dart     # Kartu tampilan item barang + aksi edit/hapus
│   ├── search_bar_widget.dart# Bilah pencarian barang
│   ├── filter_stok_chips.dart# Pilihan chip filter stok
│   ├── ringkasan_stok_widget.dart# Ringkasan mini statistik inventaris
│   ├── empty_state_widget.dart# Tampilan estetik jika list kosong
│   └── konfirmasi_hapus_dialog.dart# Dialog konfirmasi aksi hapus
├── screens/             # Halaman tampilan penuh (Scaffold)
│   ├── inventaris_screen.dart   # Halaman utama daftar inventaris (CRUD)
│   ├── form_barang_screen.dart  # Halaman formulir input & edit barang
│   ├── detail_barang_screen.dart# Halaman rincian lengkap barang
│   ├── riwayat_screen.dart      # Halaman riwayat pergerakan stok
│   └── statistik_screen.dart    # Halaman dashboard metrik inventaris
└── main.dart            # Entry point aplikasi (KHUSUS PROJECT MANAGER)
```

---

## 5. Prosedur Buka Pull Request (PR)
1. Jalankan `flutter analyze` dan pastikan tidak ada error.
2. Push branch: `git push -u origin feat/<nama-fitur>-<nama-mahasiswa>`.
3. Buka PR ke branch `main` di GitHub.
4. Isi template PR dengan lengkap: deskripsi perubahan dan screenshot aplikasi.
5. Tunggu proses code review dari **Tegar Rifa'i (PM)** sebelum dilakukan merge.
