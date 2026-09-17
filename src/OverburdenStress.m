%% Stevy Canny Louhenapessy

% =========================================================================
% SCRIPT LENGKAP GEOMEKANIKA: BACA FILE, HITUNG, 5 BLOK, PLOT, SIMPAN & EXCEL
% =========================================================================

clear; clc; close all;

% -------------------------------------------------------------------------
% 1. MEMBACA FILE TEKS
% -------------------------------------------------------------------------
filename = 'BarnettShaleData.txt';
data = readtable(filename, 'FileType', 'text');

% Ekstraksi Kolom dari Tabel
Z_depth = data.Depth_ft_;     % Kedalaman (ft)
rho_log = data.Density_g_cc_; % Density log asli (g/cc)

% -------------------------------------------------------------------------
% 2. MENETAPKAN PARAMETER KONSTANTA
% -------------------------------------------------------------------------
rho_matrix = 2.7;   % g/cm^3 (Matrix density)
rho_fluid  = 1.0;   % g/cm^3 (Fluid density)
g          = 9.8;   % m/s^2 (Gravitasi)
h          = Z_depth; % Kedalaman untuk hidrostatik

% -------------------------------------------------------------------------
% 3. PERHITUNGAN GEOMEKANIKA (RAW DATA)
% -------------------------------------------------------------------------
% A. Porositas (phi)
phi = (rho_matrix - rho_log) ./ (rho_matrix - rho_fluid);

% B. Hydrostatic Pore Pressure (Pp) dalam PSI
Pp = (rho_fluid .* 1000 .* g .* h .* 0.3048) .* 0.000145037738;

% C. Overburden Stress (Sv) Onshore (Barnett Shale) dalam PSI
Sv_onshore = (rho_log .* 1000 .* g .* Z_depth .* 0.3048) .* 0.000145037738;

% D. Overburden Stress Gradient (PSI/ft)
Sv_gradient = Sv_onshore ./ Z_depth;

% -------------------------------------------------------------------------
% 4. PEMBUATAN 5 BLOK DENSITAS BERDASARKAN RANGE KEDALAMAN URUT & RATA-RATA
% -------------------------------------------------------------------------
% Catatan: Range kedalaman harus diurutkan dari nilai terkecil ke terbesar
block_ranges = [
95,    1300;  % Blok 1
1300,  2500;  % Blok 2
2500,  3800;  % Blok 3
3800,  5000;  % Blok 4
5000,  max(Z_depth) % Blok 5
];

rho_blocked = zeros(size(Z_depth));

disp('=');
disp('            NILAI RATA-RATA DENSITAS PER BLOK                ');
disp('=');

for i = 1:size(block_ranges, 1)
z_min = block_ranges(i, 1);
z_max = block_ranges(i, 2);

% Menyeleksi indeks data dalam range kedalaman
if i == size(block_ranges, 1)
    idx = (Z_depth >= z_min) & (Z_depth <= z_max);
else
    idx = (Z_depth >= z_min) & (Z_depth < z_max);
end

% Menghitung nilai rata-rata (mean) densitas pada blok tersebut
mean_density = mean(rho_log(idx), 'omitnan');

% Memasukkan nilai rata-rata ke seluruh baris dalam range blok tersebut
rho_blocked(idx) = mean_density;

% Menampilkan info rata-rata ke Command Window
fprintf('Blok %d (Kedalaman %.1f - %.1f ft) : Rata-rata = %.4f g/cc\n', ...
    i, z_min, z_max, mean_density);


end
disp(' ');

% -------------------------------------------------------------------------
% 5. MENAMPILKAN SEMUA PERHITUNGAN DALAM BENTUK TABEL & SIMPAN KE EXCEL
% -------------------------------------------------------------------------
hasilTable = table(Z_depth, rho_log, rho_blocked, phi, Pp, Sv_onshore, Sv_gradient, ...
'VariableNames', {'Depth_ft', 'Density_Raw', 'Density_Blocked', 'Porosity', 'Pp_PSI', 'Sv_PSI', 'Sv_Gradient'});

disp('=');
disp('                    TABEL KESELURUHAN HASIL PERHITUNGAN                     ');
disp('=');
disp(hasilTable);

% Menyimpan hasil tabel ke file Excel
excel_filename = 'Hasil_Analisis_Geomekanika_Barnett.xlsx';
writetable(hasilTable, excel_filename);
fprintf('Hasil perhitungan berhasil disimpan ke file Excel: "%s"\n\n', excel_filename);

% -------------------------------------------------------------------------
% 6. MEMBUAT GRAFIK 1: MULTI-PLOT 4 KOLOM (DENSITY, POROSITY, SV, GRADIENT)
% -------------------------------------------------------------------------
fig1 = figure('Name', 'Analisis Geomekanika Barnett Shale - Multiplot', 'Position', [50, 50, 1400, 650]);

% --- Grafik 1.1: Density Raw Log vs 5 Blocked Subsections ---
subplot(1, 4, 1);
plot(rho_log, Z_depth, 'k-', 'LineWidth', 0.8);
hold on;
[unique_depths, ia, ~] = unique(Z_depth);
unique_blocked = rho_blocked(ia);
stairs(unique_blocked, unique_depths, 'r--', 'LineWidth', 2);
set(gca, 'YDir', 'reverse');
grid on;
xlim([0, 4]);
ylim([0, 7000]);
xlabel('Density (g/cc)');
ylabel('Depth (ft)');
title('Density & 5 Blocks');
legend('raw log', 'five blocked', 'Location', 'southeast');

% --- Grafik 1.2: Depth vs Porosity ---
subplot(1, 4, 2);
plot(phi, Z_depth, 'LineWidth', 1.5, 'Color', 'r');
set(gca, 'YDir', 'reverse');
grid on;
ylim([0, 7000]);
xlabel('Porosity (Fraction)');
ylabel('Depth (ft)');
title('Depth vs Porosity');

% --- Grafik 1.3: Depth vs Overburden Stress ---
subplot(1, 4, 3);
plot(Sv_onshore, Z_depth, 'LineWidth', 1.5, 'Color', 'b');
set(gca, 'YDir', 'reverse');
grid on;
ylim([0, 7000]);
xlabel('Overburden Stress (PSI)');
ylabel('Depth (ft)');
title('Depth vs Sv');

% --- Grafik 1.4: Depth vs Overburden Gradient ---
subplot(1, 4, 4);
plot(Sv_gradient, Z_depth, 'LineWidth', 1.5, 'Color', [0, 0.5, 0]);
set(gca, 'YDir', 'reverse');
grid on;
ylim([0, 7000]);
xlabel('Sv Gradient (PSI/ft)');
ylabel('Depth (ft)');
title('Depth vs Sv Gradient');

% Menyimpan Gambar Multiplot ke PNG
saveas(fig1, 'Grafik_Multiplot_Barnett.png');

% -------------------------------------------------------------------------
% 7. MEMBUAT GRAFIK 2: SV VS PORE PRESSURE & SIMPAN KE PNG
% -------------------------------------------------------------------------
fig2 = figure('Name', 'Barnett Shale - Sv vs Pore Pressure', 'Position', [100, 100, 800, 700]);

% Plot Pore Pressure (Garis Hijau)
plot(Pp, Z_depth, 'Color', [0.55, 0.75, 0.2], 'LineWidth', 2);
hold on;

% Plot Overburden Stress / Sv (Garis Ungu)
plot(Sv_onshore, Z_depth, 'Color', [0.45, 0.25, 0.55], 'LineWidth', 1.2);

% Pengaturan Tampilan Grafik
set(gca, 'YDir', 'reverse'); % Membalik sumbu Y (0 di atas, kedalaman di bawah)
grid on;

% Label, Judul, dan Legenda
xlabel('Pressure / Stress (PSI)', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('Depth (ft)', 'FontSize', 11, 'FontWeight', 'bold');
title('Barnett Shale - Sv vs Pore Pressure', 'FontSize', 14, 'FontWeight', 'bold', 'Color', [0.85, 0.45, 0]);
legend({'Pore Pressure (Pp)', 'Overburden Stress (Sv)'}, 'Location', 'southeast', 'FontSize', 10);

% Batas Sumbu (Axis Limits) Sesuai Referensi
xlim([0, 8000]);
ylim([0, 6500]);

% Menyimpan Gambar Sv vs Pp ke PNG
saveas(fig2, 'Grafik_Sv_vs_PorePressure.png');

disp('Semua proses selesai! Grafik PNG dan file Excel telah berhasil disimpan.');