# Tugas-Akhir-Flutter

## Anggota
- Ruizhi Davin - 2206026082
- Rhaken Shaquille Akbar Yanuanda - 2206814791
- Amanda Oktivia Sharfina - 2206830076
- Luhur Budi Arbilianto - 2206824262
- Nur Azizah Febriyana - 2206824363
- Maulana Seto - 2206081471
   
## Deskripsi
Pustaring, perpustakaan daring yang bertujuan untuk mempromosikan literasi, membangun komunitas pembaca yang aktif, dan memberikan akses yang mudah ke pengetahuan dan hiburan melalui buku. Dengan fitur-fitur inovatif yang kami tawarkan, Pustaring diharapkan akan menjadi sumber daya berharga bagi semua pengguna.

## Daftar Modul
- **Ulasan (Nur Azizah Febriyana)**<br>Pengguna yang telah masuk dapat menambahkan ulasan pada buku dan halaman deskripsi buku.
- **Beranda (Ruizhi Davin)**<br>Menampilkan beranda buku dengan filter yang memungkinkan pengguna menemukan buku yang sesuai dengan minat mereka.
- **Customer Service (Maulana Seto)**<br>Pengguna yang telah masuk dapat mengakses layanan pelaporan atau pengaduan.
- **Peminjaman Buku (Luhur Budi Arbilianto)**<br>Pengguna yang telah masuk dapat melakukan peminjaman buku.
- **Sistem Manajemen (Rhaken Shaquille Akbar Yanuanda)**<br>Pegawai dapat mengelola persetujuan peminjaman buku dan penyewaan ruangan serta mengelola stok buku.
- **Fitur Premium (Amanda Oktivia Sharfina)**<br>Pengguna premium dapat menyewa ruangan, mengakses buku-buku khusus, dan memiliki durasi peminjaman yang lebih lama.

## Peran Pengguna
- **Tamu**<br>Pengguna default yang hanya dapat membaca buku dan ulasan.
- **Pengguna Biasa**<br>Pengguna yang dapat membaca buku, membaca ulasan, menambah ulasan, dan meminjam buku.
- **Pengguna Premium**<br>Pengguna yang dapat membaca buku, membaca ulasan, menambah ulasan, meminjam buku, mengakses buku-buku khusus, menyewa ruangan, dan memiliki batas durasi peminjaman yang lebih lama.
- **Pegawai**<br>Pegawai yang dapat mengakses fitur manajemen perpustakaan.

## Alur Pengintegrasian
1. Laman web PTS yang telah di-*deploy* akan diatur agar memiliki *backend* yang dapat menampilkan data-data terkait dalam format JSON. 
2. Membuat berkas bernama `fetch.dart` dalam folder `utils` di modul `apps` masing-masing anggota untuk mengakses data JSON dari *backend* secara asinkronus. Berkas `fetch.dart` dilengkapi dengan fungsi yang dapat dipanggil untuk mengembalikan data yang diperlukan dalam suatu *list*. 
3. Fungsi di dalam berkas `fetch.dart` memiliki *url* yang dapat digunakan sebagai *endpoint* JSON untuk mengintegrasi aplikasi.
4. Pemanggilan fungsi dilakukan di *widget* untuk diolah sesuai dengan kebutuhan fitur dari masing-masing modul.

## Berita Acara
https://docs.google.com/spreadsheets/d/171DiVqzsgO_UzHdiebzTAQt6rMUklaqAm-gg-xunmzM/edit?usp=sharing 
