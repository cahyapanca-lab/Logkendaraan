# Log Motor Kantor

Web app statis (GitHub Pages) + database Supabase. Excel diunduh lewat tombol **Unduh Excel**.

## Setup
1. **Supabase**: buat project gratis di supabase.com, buka *SQL Editor*, jalankan `supabase.sql`.
2. *Authentication > Providers > Email*: matikan **Allow new users to sign up**. Tambah pegawai lewat *Authentication > Users > Add user*.
3. Salin *Project URL* dan *anon key* (Project Settings > API) ke `config.js`.
4. **GitHub**: buat repo, upload semua file ini, lalu *Settings > Pages > Deploy from branch > main / root*.
5. Buka `https://<username>.github.io/<nama-repo>/` dan masuk.

## Excel yang selalu terhubung (opsional)
Cara termudah: tombol **Unduh Excel** (selalu berisi data terbaru, mengikuti filter bulan/motor).
Untuk file Excel yang bisa di-*Refresh*, gunakan Power Query (Data > Get Data > From Web > Advanced) ke
`<SUPABASE_URL>/rest/v1/trips_export` dengan header `apikey` dan `Authorization: Bearer <token>`; hasilnya JSON
yang diubah ke tabel. Karena tabel dilindungi login, ini butuh token, jadi pakai hanya jika memang diperlukan.
