# Tugas 1: Analisis Tegangan Overburden dan Porositas
**Mata Kuliah:** Geomekanika Reservoir  
**Sumber Referensi:** [Stanford Online - Reservoir Geomechanics](https://online.stanford.edu/courses/soeees-ygeoresgeo202-reservoir-geomechanics)

---

## Gambaran Umum Tugas

Pada penugasan mandiri kali ini, kita akan melakukan pemodelan dan perhitungan tegangan vertikal ($S_{v}$) beserta porositas formasi ($\phi$) menggunakan dua set data riil. Data pertama berasal dari formasi *Barnett Shale* di Texas, sementara data kedua bersumber dari sumur bawah laut (*offshore*) di Teluk Meksiko (GOM). Set data ini dirancang untuk menjadi fondasi analisis pada rangkaian tugas berikutnya. 

Anda disarankan menggunakan perangkat lunak komputasi teknis seperti MATLAB atau Microsoft Excel guna menyelesaikan seluruh tahapan komputasi dan visualisasi grafik di bawah ini.

## Panduan Pengerjaan

### Bagian 1: Pemodelan Tegangan Overburden dan Gradiennya

1. **Visualisasi Densitas terhadap Kedalaman:**  
   Buat grafik densitas pada sumbu horizontal (x) dan kedalaman pada sumbu vertikal terbalik (y) untuk masing-masing sumur. Mengingat rekaman log biasanya tidak dimulai tepat di permukaan, terapkan asumsi berikut:
   * **Data Barnett:** Tetapkan densitas $1.9\text{ g/cc}$ mulai dari permukaan tanah hingga titik bacaan sensor pertama.
   * **Data GOM:** Karena berlokasi di lepas pantai, gunakan densitas $1.0\text{ g/cc}$ dari permukaan air laut menuju dasar laut ($1000\text{ kaki}$), dilanjutkan densitas $1.8\text{ g/cc}$ untuk lapisan sedimen dangkal dari kedalaman $1001\text{ kaki}$ hingga titik awal data log.

2. **Penyederhanaan Profil Melalui Pembagian Blok:**  
   Amati tren fluktuasi densitas pada grafik, lalu bagi setiap profil menjadi 5 zona atau blok utama yang mencerminkan rentang densitas konstan. Tentukan nilai densitas rata-rata di tiap blok dan sajikan grafik profil terblok ini terhadap kedalaman.

3. **Kalkulasi Tegangan Overburden ($S_{v}$):**  
   Hitung serta gambarkan profil tegangan overburden menggunakan data kontinu dan data terblok. Tampilkan pula kurva tekanan pori hidrostatik (asumsi densitas fluida pori $1.0\text{ g/cc}$) pada grafik yang sama. Gunakan konstanta percepatan gravitasi $g = 9.80\text{ m/s}^{2}$ ($32.17\text{ ft/s}^{2}$) dan lakukan konversi satuan akhir ke dalam **PSI**.

4. **Analisis Gradien Overburden:**  
   Tentukan nilai gradien overburden—yakni rasio tegangan overburden terhadap kedalaman dalam satuan $\text{PSI/ft}$—menggunakan data log kontinu murni (bukan data terblok), lalu buat plot visualisasinya.

### Bagian 2: Estimasi Porositas Berbasis Log Densitas

1. **Penerapan Persamaan Hubungan Densitas:**  
   Hitung nilai porositas ($\phi$) dengan asumsi kondisi jenuh penuh (*complete saturation*) serta tekanan pori hidrostatik melalui formulasi:
   $$
   \rho_{\text{log}} = (1 - \phi)\rho_{\text{matrix}} + \phi\rho_{\text{fluid}}
   $$
   *Keterangan:* Gunakan densitas matriks batuan reservoir ($\rho_{\text{matrix}}$) sebesar $2.7\text{ g/cc}$ dan densitas fluida pori ($\rho_{\text{fluid}}$) sebesar $1.0\text{ g/cc}$.

2. **Pemetaan Porositas:**  
   Buat grafik yang memetakan porositas terhadap kedalaman untuk kedua sumur, baik dengan pendekatan profil densitas kontinu maupun terblok.

### Bagian 3: Pelaporan dan Evaluasi Jawaban

Manfaatkan hasil kurva dan komputasi dari Bagian 1 serta 2 untuk menyelesaikan pertanyaan evaluasi akhir. Perhatikan instruksi format penulisan jawaban: sistem penilaian otomatis mensyaratkan penggunaan nilai konstanta yang presisi seperti yang telah ditetapkan di atas. Tuliskan **hanya nilai angkanya saja** tanpa menyertakan satuan fisik pada lembar jawaban akhir.