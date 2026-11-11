# AI Agent & Contributor Guidelines: informatika24_mobile

Repositori ini adalah proyek Flutter untuk tugas mata kuliah Pemrograman Mobile dengan arsitektur modular CRUD Inventaris Laboratorium.

---

## 1. Arsitektur Folder & Aturan Penempatan File
Setiap kode baru **WAJIB** dipisahkan ke file tersendiri sesuai fungsinya:
- `lib/models/` : Model data (contoh: [barang.dart](file:///d:/Proyek/Mobile/informatika24_mobile/lib/models/barang.dart)).
- `lib/services/` : Layer penyimpanan/service (contoh: SharedPreferences, SQLite helper).
- `lib/screens/` : Halaman/tampilan layar utama (contoh: [inventaris_screen.dart](file:///d:/Proyek/Mobile/informatika24_mobile/lib/screens/inventaris_screen.dart), [form_barang_screen.dart](file:///d:/Proyek/Mobile/informatika24_mobile/lib/screens/form_barang_screen.dart)).
- `lib/widgets/` : Reusable components/widget kecil (contoh: [barang_card.dart](file:///d:/Proyek/Mobile/informatika24_mobile/lib/widgets/barang_card.dart), search bar, dialog konfirmasi).
- `lib/main.dart` : Entry point aplikasi saja. **DILARANG** menambahkan logika CRUD atau widget tampilan halaman baru di dalam `main.dart`.

---

## 2. Prinsip Penulisan Kode (Clean & Anti-Bloat)
1. **Reusable Component**: Komponen UI baru wajib diletakkan di file terpisah dalam `lib/widgets/` atau `lib/screens/`.
2. **Minimalis & Tepat Sasaran**: Hindari menambah package yang tidak perlu jika bisa diselesaikan dengan native Flutter.
3. **Analisis Bebas Error**: Pastikan kode selalu lolos `flutter analyze` tanpa ada warning atau error.
4. **Pertahankan Fondasi CRUD**: Fitur tambahan tidak boleh merusak alur dasar Create, Read, Update, Delete data inventaris.

---

## 3. Standar Git & Pull Request
- **Branch**: Buat branch baru dari `main` dengan format: `feat/<nama-fitur>-<nama-mahasiswa>` (contoh: `feat/search-bar-budi`).
- **Commit**: Gunakan pesan commit yang jelas dan spesifik (contoh: `feat(widget): tambahkan search bar`, `fix(form): perbaiki validasi stok`).
- **Pull Request**: Buka PR ke branch `main` dengan mencantumkan ringkasan perubahan dan screenshot fitur yang berjalan.
