clear all;
close all;
clc;

load carsmall;

%% Frame diff results no post-processing
Table=csvread(['data_fd_60.csv']);
dists = Table(:, 2);
dists = flip(dists);
thetas = Table(:, 3);
thetas = flip(thetas);

f_1 = figure;
tiledlayout(2, 1);
nexttile
plot(dists, '.');
subtitle("Distances btw points 0 deg")
xlim([0 length(dists)])
ylabel('Speed [pixel distance]')
xlabel('Frame [#]')

x=(1:1:length(dists));
y=transpose(dists);
coeff=polyfit(x, y, 1);
z=polyval(coeff , x);
err2=norm(z - y, 2);
fprintf('\n\t ErrorRegression norma2 : %1.2e ' , err2 ) ;
ht =1/10000; u=0:ht:length(thetas);
v=polyval(coeff, u);
hold on
plot(u, v);


nexttile
plot(thetas, '.');
subtitle("Angles from X axis 0 deg")
xlim([0 length(thetas)])
ylabel('Theta [deg]')
xlabel('Frame [#]')

x=(1:1:length(thetas));
y=transpose(thetas);
coeff=polyfit(x, y, 1);
z=polyval(coeff , x);
err2=norm(z - y, 2);
%fprintf('\n\t ErrorRegression norma2 : %1.2e ' , err2 ) ;
ht =1/10000; u=0:ht:length(thetas);
v=polyval(coeff, u);
hold on
%plot(u, v);
disp("|||||\n")
disp(mean(thetas));
hold on
yline(mean(thetas), '--r');
disp(std(thetas));
hold on
disp(trimmean(thetas, 30));
%text(10,0,sprintf('MODE=%.2f',m))

%% Frame diff results no post-processing rotated
Table=csvread(['/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_fd_rot.csv']);
dists_rot = Table(:, 1);
thetas_rot = Table(:, 2);

f_1b = figure;
tiledlayout(2, 1);
nexttile
plot(dists_rot, '.');
subtitle("Distances btw points rot 45°")
xlim([0 length(dists_rot)])
ylabel('Speed [pixel distance]')
xlabel('Frame [#]')

x=(1:1:length(dists_rot));
y=transpose(dists_rot);
coeff=polyfit(x, y, 1);
z=polyval(coeff , x);
err2=norm(z - y, 2);
fprintf('\n\t ErrorRegression norma2 : %1.2e ' , err2 ) ;
ht =1/10000; u=0:ht:length(thetas);
v=polyval(coeff, u);
hold on
plot(u, v);

nexttile
plot(thetas_rot, '.');
subtitle("Angles from X axis rot 45°")
xlim([0 length(thetas_rot)])
ylabel('Theta [deg]')
xlabel('Frame [#]')

x=(1:1:length(thetas_rot));
y=transpose(thetas_rot);
coeff=polyfit(x, y, 1);
z=polyval(coeff , x);
err2=norm(z - y, 2);
fprintf('\n\t ErrorRegression norma2 : %1.2e ' , err2 ) ;
ht =1/10000; u=0:ht:length(thetas);
v=polyval(coeff, u);
hold on
plot(u, v);

%% DFT analysis of maximum center colum different speeds
Table0=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_0.csv');
Table1=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_1.csv');
Table2=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_2.csv');
Table3=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_3.csv');

vel_0 = Table0(:, 1);
vel_1 = Table1(:, 1);
vel_2 = Table2(:, 1);
vel_3 = Table3(:, 1);

f_2 = figure;
f_2.Position = [200 200 1000 1000];
tiledlayout(2, 2);
nexttile
plot(vel_0);
[max_value,index]=max(vel_0);
hold on

subtitle("vel_0")
xlim([0 length(vel_0)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')
plot(index, max_value, 'ro')
nexttile
plot(vel_1);
[max_value,index]=max(vel_1);
hold on
plot(index, max_value, 'ro')
subtitle("vel_1")
xlim([0 length(vel_1)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

nexttile
plot(vel_2);
[max_value,index]=max(vel_2);
hold on
plot(index, max_value, 'ro')
subtitle("vel_2")
xlim([0 length(vel_2)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

nexttile
plot(vel_3);
[max_value,index]=max(vel_3);
hold on
plot(index, max_value, 'ro')
subtitle("vel_3")
xlim([0 length(vel_3)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

%% DFT analysis of maximum center colum different speeds rotated
Table0=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_0_rot.csv');
Table1=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_1_rot.csv');
Table2=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_2_rot.csv');
Table3=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_3_rot.csv');

vel_0_rot = Table0(:, 1);
vel_1_rot = Table1(:, 1);
vel_2_rot = Table2(:, 1);
vel_3_rot = Table3(:, 1);

f_3 = figure;
f_3.Position = [200 200 1000 1000];
tiledlayout(2, 2);
nexttile
plot(vel_0_rot);
[max_value,index]=max(vel_0_rot);
hold on
plot(index, max_value, 'ro')
subtitle("vel_0 rot")
xlim([0 length(vel_0_rot)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

nexttile
plot(vel_1_rot);
[max_value,index]=max(vel_1_rot);
hold on
plot(index, max_value, 'ro')
subtitle("vel_1 rot")
xlim([0 length(vel_1_rot)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

nexttile
plot(vel_2_rot);
subtitle("vel_2 rot")
[max_value,index]=max(vel_2_rot);
hold on
plot(index, max_value, 'ro')
xlim([0 length(vel_2_rot)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

nexttile
plot(vel_3_rot);
[max_value,index]=max(vel_3_rot);
hold on
plot(index, max_value, 'ro')
subtitle("vel_3 rot")
xlim([0 length(vel_3_rot)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

%% DFT analysis of maximum center colum different speeds rotated with noise blob
Table0=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_noise_0_rot.csv');
Table1=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_noise_1_rot.csv');
Table2=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_noise_2_rot.csv');
Table3=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_noise_3_rot.csv');

vel_ns_0_rot = Table0(:, 1);
vel_ns_1_rot = Table1(:, 1);
vel_ns_2_rot = Table2(:, 1);
vel_ns_3_rot = Table3(:, 1);

f_3 = figure;
f_3.Position = [200 200 1000 1000];
tiledlayout(2, 2);
nexttile
plot(vel_ns_0_rot);
[max_value,index]=max(vel_ns_0_rot);
hold on
plot(index, max_value, 'ro')
subtitle("vel_0 rot with noise")
xlim([0 length(vel_ns_0_rot)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

nexttile
plot(vel_ns_1_rot);
[max_value,index]=max(vel_ns_1_rot);
hold on
plot(index, max_value, 'ro')
subtitle("vel_1 rot with noise")
xlim([0 length(vel_ns_1_rot)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

nexttile
plot(vel_ns_2_rot);
subtitle("vel_2 rot with noise")
[max_value,index]=max(vel_ns_2_rot);
hold on
plot(index, max_value, 'ro')
xlim([0 length(vel_ns_2_rot)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

nexttile
plot(vel_ns_3_rot);
[max_value,index]=max(vel_ns_3_rot);
hold on
plot(index, max_value, 'ro')
subtitle("vel_3 rot with noise")
xlim([0 length(vel_ns_3_rot)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

%% DFT analysis of maximum center colum different speeds rotated with noise salt and pepper
Table0=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_noise_sp_0_rot.csv');
Table1=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_noise_sp_1_rot.csv');
Table2=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_noise_sp_2_rot.csv');
Table3=csvread('/home/matteospadetto/Documents/unitn_ms/Thesis_sw/gvs/data_csv/data_freq_noise_sp_3_rot.csv');

vel_ns_sp_0_rot = Table0(:, 1);
vel_ns_sp_1_rot = Table1(:, 1);
vel_ns_sp_2_rot = Table2(:, 1);
vel_ns_sp_3_rot = Table3(:, 1);

f_3 = figure;
f_3.Position = [200 200 1000 1000];
tiledlayout(2, 2);
nexttile
plot(vel_ns_sp_0_rot);
[max_value,index]=max(vel_ns_sp_0_rot);
hold on
plot(index, max_value, 'ro')
subtitle("vel_0 rot with sp noise")
xlim([0 length(vel_ns_sp_0_rot)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

nexttile
plot(vel_ns_sp_1_rot);
[max_value,index]=max(vel_ns_sp_1_rot);
hold on
plot(index, max_value, 'ro')
subtitle("vel_1 rot with sp  noise")
xlim([0 length(vel_ns_sp_1_rot)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

nexttile
plot(vel_ns_sp_2_rot);
subtitle("vel_2 rot with sp noise")
[max_value,index]=max(vel_ns_sp_2_rot);
hold on
plot(index, max_value, 'ro')
xlim([0 length(vel_ns_sp_2_rot)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

nexttile
plot(vel_ns_sp_3_rot);
[max_value,index]=max(vel_ns_sp_3_rot);
hold on
plot(index, max_value, 'ro')
subtitle("vel_3 rot with sp noise")
xlim([0 length(vel_ns_sp_3_rot)])
xlabel('Pixel on center col [#]')
ylabel('Magnitude of dft of pixel [dB]')

%% HOG analysis
Tablel=csvread('data_hog.csv');

dir_hog = Tablel(:, 2);
bins_hog = Tablel(:, 1);

f_3 = figure;
bar(bins_hog, dir_hog);

range0 = (1:length(dir_hog));
A0 = dir_hog(range0);
[max_value0,index0]=max(A0);
org0 = range0(index0);
hold on
plot(floor(org0/2), max_value0, 'ro')


% 
% range1 = (length(vel_hog)/2)+1 : length(vel_hog);
% A1 = vel_hog(range1);
% [max_value1,index1]=max(A1);
% org1 = range1(index1);
% hold on
% plot(floor(org1/2), max_value1, 'ro')

hold on
xline(180, '--r')

subtitle("HOG direction 5°")
xlim([0 360])
xlabel('Degrees of rotation [°]')
ylabel('Bins per direction [#]')

%% HOG speed and dir
Tablel=csvread('data_hog_tot_30_blob.csv');

vel_hog = Tablel(:, 3);
dir_hog = Tablel(:, 2);
bins_hog = Tablel(:, 1);
f_4 = figure;
tiledlayout(2, 1);
nexttile
plot(bins_hog, dir_hog);
subtitle("HOG direction 45°")
xlabel('Blur size [#]')
ylabel('Degrees of rotation [°]')
hold on
nexttile
plot(bins_hog, vel_hog);
subtitle("HOG speed 45°")
xlabel('Blur size [#]')
ylabel('Speed [std dev]')

%% HOG speed comparison
fig_0 = figure;
subtitle("HOG speed comparison diff rotations")
xlabel('Sample frame [#]')
ylabel('Speed [std dev]')
hold on

Table30=csvread('data_hog_tot_30.csv');
bins_hog_30 = Table30(:, 1);
dir_hog_30 = Table30(:, 2);
vel_hog_30 = Table30(:, 3);
plot(bins_hog_30, vel_hog_30)
hold on

Table45=csvread('data_hog_tot_45.csv');
bins_hog_45 = Table45(:, 1);
dir_hog_45 = Table45(:, 2);
vel_hog_45 = Table45(:, 3);
plot(bins_hog_45, vel_hog_45)
hold on

Table60=csvread('data_hog_tot_60.csv');
bins_hog_60 = Table60(:, 1);
dir_hog_60 = Table60(:, 2);
vel_hog_60 = Table60(:, 3);
plot(bins_hog_60, vel_hog_60)
hold on

Table85=csvread('data_hog_tot_85.csv');
bins_hog_85 = Table85(:, 1);
dir_hog_85 = Table85(:, 2);
vel_hog_85 = Table85(:, 3);
plot(bins_hog_85, vel_hog_85)
hold on

Table90=csvread('data_hog_tot_90.csv');
bins_hog_90 = Table90(:, 1);
dir_hog_90 = Table90(:, 2);
vel_hog_90 = Table90(:, 3);
plot(bins_hog_90, vel_hog_90)

%% HOG speed comparison noise blob
fig_0 = figure;
subtitle("HOG speed comparison blob noise 30 deg")
xlabel('Sample frame [#]')
ylabel('Speed [std dev]')
hold on

Table30=csvread('data_hog_tot_30.csv');
bins_hog_30 = Table30(:, 1);
vel_hog_30 = Table30(:, 3);
plot(bins_hog_30, vel_hog_30)
hold on

Table30_blob=csvread('data_hog_tot_30_blob.csv');
bins_hog_30_blob = Table30_blob(:, 1);
vel_hog_30_blob = Table30_blob(:, 3);
plot(bins_hog_30_blob, vel_hog_30_blob, 'r')

%% HOG speed comparison noise sp
fig_0 = figure;
subtitle("HOG speed comparison sp noise 30 deg")
xlabel('Sample frame [#]')
ylabel('Speed [std dev]')
hold on

Table30=csvread('data_hog_tot_30.csv');
bins_hog_30 = Table30(:, 1);
vel_hog_30 = Table30(:, 3);
plot(bins_hog_30, vel_hog_30)
hold on

Table30_sp=csvread('data_hog_tot_30_sp.csv');
bins_hog_30_sp = Table30_sp(:, 1);
vel_hog_30_sp = Table30_sp(:, 3);
plot(bins_hog_30_sp, vel_hog_30_sp, 'r')

%% Laplacian speed
Table0=csvread('data_lap_30.csv');

vel_hog = Table0(:, 2);
bins_hog = Table0(:, 1);
f_4 = figure;
plot(bins_hog, vel_hog, '.');
subtitle("LAP speed 30°")
xlabel('Blur size [#]')
ylabel('Speed [std dev]')

%% LAP speed comparison
fig_0 = figure;
subtitle("LAP speed comparison diff rotations")
xlabel('Sample frame [#]')
ylabel('Speed [std dev]')
hold on

Table30=csvread('data_lap_30.csv');
bins_hog_30 = Table30(:, 1);
vel_hog_30 = Table30(:, 2);
plot(bins_hog_30, vel_hog_30, '.')
hold on

Table45=csvread('data_lap_45.csv');
bins_hog_45 = Table45(:, 1);
vel_hog_45 = Table45(:, 2);
plot(bins_hog_45, vel_hog_45, '.')
hold on

Table60=csvread('data_lap_60.csv');
bins_hog_60 = Table60(:, 1);
vel_hog_60 = Table60(:, 2);
plot(bins_hog_60, vel_hog_60, '.')
hold on

Table85=csvread('data_lap_85.csv');
bins_hog_85 = Table85(:, 1);
vel_hog_85 = Table85(:, 2);
plot(bins_hog_85, vel_hog_85, '.')
hold on

Table90=csvread('data_lap_90.csv');
bins_hog_90 = Table90(:, 1);
vel_hog_90 = Table90(:, 2);
plot(bins_hog_90, vel_hog_90, '.')

%% LAP speed noise blob comparison
fig_0 = figure;
subtitle("LAP speed comparison blob noise 30 deg")
xlabel('Sample frame [#]')
ylabel('Speed [std dev]')
hold on

Table30=csvread('data_lap_30.csv');
bins_hog_30 = Table30(:, 1);
vel_hog_30 = Table30(:, 2);
plot(bins_hog_30, vel_hog_30, '.')
hold on

Table30_blob=csvread('data_lap_30_blob.csv');
bins_hog_30_blob = Table30_blob(:, 1);
vel_hog_30_blob = Table30_blob(:, 2);
plot(bins_hog_30_blob, vel_hog_30_blob, '.')

%% LAP speed noise sp comparison
fig_0 = figure;
subtitle("LAP speed comparison sp noise 30 deg")
xlabel('Sample frame [#]')
ylabel('Speed [std dev]')
hold on

Table30=csvread('data_lap_30.csv');
bins_hog_30 = Table30(:, 1);
vel_hog_30 = Table30(:, 2);
plot(bins_hog_30, vel_hog_30, '.')
hold on

Table30_sp=csvread('data_lap_30_sp.csv');
bins_hog_30_sp = Table30_sp(:, 1);
vel_hog_30_sp = Table30_sp(:, 2);
plot(bins_hog_30_sp, vel_hog_30_sp, '.')

%% LAP speed comparison MORPH
fig_0 = figure;
subtitle("LAP speed comparison diff rotations morph")
xlabel('Sample frame [#]')
ylabel('Speed [std dev]')
hold on

Table30=csvread('data_lap_30_morph.csv');
bins_hog_30 = Table30(:, 1);
vel_hog_30 = Table30(:, 2);
plot(bins_hog_30, vel_hog_30, '.')
hold on

Table45=csvread('data_lap_45_morph.csv');
bins_hog_45 = Table45(:, 1);
vel_hog_45 = Table45(:, 2);
plot(bins_hog_45, vel_hog_45, '.')
hold on

Table60=csvread('data_lap_60_morph.csv');
bins_hog_60 = Table60(:, 1);
vel_hog_60 = Table60(:, 2);
plot(bins_hog_60, vel_hog_60, '.')
hold on

Table85=csvread('data_lap_85_morph.csv');
bins_hog_85 = Table85(:, 1);
vel_hog_85 = Table85(:, 2);
plot(bins_hog_85, vel_hog_85, '.')
hold on

Table90=csvread('data_lap_90_morph.csv');
bins_hog_90 = Table90(:, 1);
vel_hog_90 = Table90(:, 2);
plot(bins_hog_90, vel_hog_90, '.')

x = bins_hog_30(1:17)
%pf = fit(x, y, 'rat01')
hold on
pfv1 = 25 * exp(-0.074*x) + 5
plot(x, pfv1, 'r', 'LineWidth',2)
hold on
x = bins_hog_30(16:91)
pfv2 = 12.4* exp(-0.0325*x) + 5
plot(x, pfv2 ,'r',  'LineWidth',2)
hold on
x = bins_hog_30(90:end)
pfv3 = 7 -0.015* x
plot(x, pfv3 ,'r',  'LineWidth',2)

%% LAP speed noise blob comparison MORPH
fig_0 = figure;
subtitle("LAP speed comparison blob noise 90 deg morph")
xlabel('Sample frame [#]')
ylabel('Speed [std dev]')
hold on

Table30=csvread('data_lap_90_morph.csv');
bins_hog_30 = Table30(:, 1);
vel_hog_30 = Table30(:, 2);
plot(bins_hog_30, vel_hog_30, '.')
hold on

Table30_blob=csvread('data_lap_90_morph_blob.csv');
bins_hog_30_blob = Table30_blob(:, 1);
vel_hog_30_blob = Table30_blob(:, 2);
plot(bins_hog_30_blob, vel_hog_30_blob, '.')

%% LAP speed noise sp comparison MORPH
fig_0 = figure;
subtitle("LAP speed comparison sp noise 90 deg morph")
xlabel('Sample frame [#]')
ylabel('Speed [std dev]')
hold on

Table30=csvread('data_lap_90_morph.csv');
bins_hog_30 = Table30(:, 1);
vel_hog_30 = Table30(:, 2);
plot(bins_hog_30, vel_hog_30, '.')
hold on

Table30_sp=csvread('data_lap_90_morph_sp.csv');
bins_hog_30_sp = Table30_sp(:, 1);
vel_hog_30_sp = Table30_sp(:, 2);
plot(bins_hog_30_sp, vel_hog_30_sp, '.')

%% LAP speed 700
fig_0 = figure;
subtitle("LAP high speed")
xlabel('Sample frame [#]')
ylabel('Speed [std dev]')
hold on

Table30=csvread('data_lap_45_700.csv');
bins_hog_30 = Table30(:, 1);
vel_hog_30 = Table30(:, 2);
plot(bins_hog_30, vel_hog_30, '.')
