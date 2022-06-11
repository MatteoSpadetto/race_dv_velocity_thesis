clear all;
close all;
clc;

load carsmall;

%% Frame diff results no post-processing
Table=csvread(['data_fd_45.csv']);
dists = Table(:, 2);
dists = flip(dists);
thetas = Table(:, 3);
thetas = flip(thetas);

f_1 = figure;
tiledlayout(2, 1);
nexttile
plot(dists, '.');
subtitle("Displacement magnitude frames at 45 deg constant direction")
xlim([0 length(dists)]) 
ylabel('Mode disp. lengths [px]')
xlabel('Frame difference step [#]')

nexttile
plot(thetas, '.');
subtitle("Displacement direction frames at 45 deg constant direction")
xlim([0 length(thetas)])
ylabel('Mode disp. directions [deg]')
xlabel('Frame difference step [#]')

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
yline(45, '--r');
disp(std(thetas));
hold on
disp(trimmean(thetas, 30));
%text(10,0,sprintf('MODE=%.2f',m))

%% HOG analysis
Tablel=csvread('data_c.csv');

dir_hog = Tablel(:, 2);
bins_hog = Tablel(:, 1);

f_3 = figure;
bar(bins_hog, dir_hog);

hold on
xline(180, '--r')

subtitle("HOG direction detection 45 deg")
xlim([0 360])
xlabel('Direction bins [deg]')
ylabel('Sum of px magnitudes per bin [#]')

%% HOG analysis
Tablel=csvread('data_csv_45_t.csv');

bins_hog = Tablel(:, 1);

f_3 = figure;
plot(bins_hog);

hold on
xline(180, '--r')

subtitle("HOG direction detection 45 deg")
xlim([0 360])
xlabel('Direction bins [deg]')
ylabel('Sum of px magnitudes per bin [#]')

%% HOG speed and dir
Tablel=csvread('data_hog_tot_45.csv');

vel_hog = Tablel(:, 3);
dir_hog = Tablel(:, 2);
bins_hog = Tablel(:, 1);
f_4 = figure;
tiledlayout(2, 1);
nexttile
plot(bins_hog, dir_hog);
subtitle("HOG direction detection 45 deg")
xlabel('Blur kernel size NxN [#]')
ylabel('Angle [deg]')
hold on
yline(45, '--r')
hold on
nexttile
plot(bins_hog, vel_hog);
subtitle("HOG speed detection 45°")
xlabel('Blur kernel size NxN [#]')
ylabel('Frame std dev [Intensity]')

%% HOG speed comparison
fig_0 = figure;
subtitle("HOG speed detection at different angles")
xlabel('Blur kernel size NxN [#]')
ylabel('Frame std dev [Intensity]')
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

legend('30 deg', '45 deg', '60 deg', '85 deg')

% Table90=csvread('data_hog_tot_90.csv');
% bins_hog_90 = Table90(:, 1);
% dir_hog_90 = Table90(:, 2);
% vel_hog_90 = Table90(:, 3);
% plot(bins_hog_90, vel_hog_90)

%% HOG speed comparison noise blob
fig_0 = figure;
subtitle("HOG speed blob noise 45 deg")
xlabel('Blur kernel size NxN [#]')
ylabel('Frame std dev [Intensity]')
hold on

Table30=csvread('data_hog_tot_45.csv');
bins_hog_30 = Table30(:, 1);
vel_hog_30 = Table30(:, 3);
plot(bins_hog_30, vel_hog_30)
hold on

Table30_blob=csvread('data_hog_tot_45_blob.csv');
bins_hog_30_blob = Table30_blob(:, 1);
vel_hog_30_blob = Table30_blob(:, 3);
plot(bins_hog_30_blob, vel_hog_30_blob, 'r')

%% HOG speed comparison noise sp
fig_0 = figure;
subtitle("HOG speed salt noise 45 deg")
xlabel('Blur kernel size NxN [#]')
ylabel('Frame std dev [Intensity]')
hold on

Table30=csvread('data_hog_tot_45.csv');
bins_hog_30 = Table30(:, 1);
vel_hog_30 = Table30(:, 3);
plot(bins_hog_30, vel_hog_30)
hold on

Table30_sp=csvread('data_hog_tot_45_sp.csv');
bins_hog_30_sp = Table30_sp(:, 1);
vel_hog_30_sp = Table30_sp(:, 3);
plot(bins_hog_30_sp, vel_hog_30_sp, 'r')

%% Laplacian speed
Table0=csvread('data_lap_45.csv');

vel_hog = Table0(:, 2);
bins_hog = Table0(:, 1);
f_4 = figure;
plot(bins_hog, vel_hog, '.');
subtitle("Laplacian speed 45 deg")
xlabel('Blur kernel size NxN [#]')
ylabel('Frame standard deviation [Intensity]')

%% LAP speed comparisonbins_hog
fig_0 = figure;
subtitle("Laplacian speed comparison a different angles")
xlabel('Blur kernel size NxN [#]')
ylabel('Derivatives standard deviation [#]')
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

hold on
x = bins_hog_30(1:17)
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

hold on
xline(17, '--');
hold on
xline(91, '--');

xticks([17 91])

hold on 
legend('30 deg', '45 deg', '60 deg', '85 deg', '90 deg', 'mod1', 'mod2', 'mod3')

%% LAP speed noise blob comparison
fig_0 = figure;
subtitle("Laplacian speed with blob noise at 45 deg")
xlabel('Blur kernel size NxN [#]')
ylabel('Derivatives standard deviation [#]')
hold on

Table30=csvread('data_lap_45.csv');
bins_hog_30 = Table30(:, 1);
vel_hog_30 = Table30(:, 2);
plot(bins_hog_30, vel_hog_30, '.')
hold on

Table30_blob=csvread('data_lap_45_blob.csv');
bins_hog_30_blob = Table30_blob(:, 1);
vel_hog_30_blob = Table30_blob(:, 2);
plot(bins_hog_30_blob, vel_hog_30_blob, '.')

hold on
legend('Reference', 'Blob noise')

%% LAP speed noise sp comparison
fig_0 = figure;
subtitle("Laplacian speed with salt noise at 45 deg")
xlabel('Blur kernel size NxN [#]')
ylabel('Derivatives standard deviation [#]')
hold on

Table30=csvread('data_lap_45.csv');
bins_hog_30 = Table30(:, 1);
vel_hog_30 = Table30(:, 2);
plot(bins_hog_30, vel_hog_30, '.')
hold on

Table30_sp=csvread('data_lap_45_sp.csv');
bins_hog_30_sp = Table30_sp(:, 1);
vel_hog_30_sp = Table30_sp(:, 2);
plot(bins_hog_30_sp, vel_hog_30_sp, '.')

hold on
legend('Reference', 'Salt noise')

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

%% TOT analysis
Table=csvread('data_csv_45_new.csv');
thetas = Table(:, 1);
dists = Table(:, 2);

f_1 = figure;
tiledlayout(2, 1);
nexttile
plot(dists, '.');
subtitle("Euclidian distance btw frames 3 deg")
xlim([0 length(dists)])
ylabel('Magnitude [px]')
xlabel('Difference [#]')
hold on

nexttile
plot(thetas, '.');
subtitle("Direction of shift btw frames 3 deg")
xlim([0 length(thetas)])
ylabel('Angle [deg]')
xlabel('Difference [#]')

%x=(1:1:length(thetas));
%y=transpose(thetas);
% coeff=polyfit(x, y, 1);
% z=polyval(coeff , x);
% err2=norm(z - y, 2);
%fprintf('\n\t ErrorRegression norma2 : %1.2e ' , err2 ) ;
%ht =1/10000; u=0:ht:length(thetas);
%v=polyval(coeff, u);
%hold on
%plot(u, v);
%disp(mean(thetas));
%disp("|||||\n")
hold on
yline(3, '--r');
%disp(std(thetas));
%hold on
%disp(trimmean(thetas, 30));
%text(10,0,sprintf('MODE=%.2f',m))

%% Motion blur
Table = load(['../../../sim_log/sine_steer1.mat']);

u = Table.VehicleModel_VM_Outputs_States_u;
v = Table.VehicleModel_VM_Outputs_States_v;
fl = Table.VehicleModel_VM_Outputs_AdditionalStates_delta_fl;
fr = Table.VehicleModel_VM_Outputs_AdditionalStates_delta_fr;

amp = [];
theta = [];

for n = 1:length(u)
    amp(end + 1) = sqrt((u(n) *u(n)) + ( v(n) * v(n)));
    theta(end + 1) = (fl(n) + fr(n))/2;
end

for c = 95:200
    if (c < 10)
        path = '000' + string(c);
    elseif(c >= 10 && c < 100)
        path = '00' + string(c);
    elseif(c >= 100 && c < 1000)
        path = '0' + string(c);
    else
        path = string(c);
    end
    k=0;
    A = imread('../../../60fps_1cd/gss_camera/' + path + '.png');
    if (c > 115)
        H = fspecial('motion',amp(c+5120+k)*7,(theta(c+5120+k)*180/pi)-90);
        MotionBlur = imfilter(A ,H,'replicate');
        k= k+ 40;
    else
        MotionBlur = A;
    end
    imwrite(MotionBlur, '../../../test_60fps_1cd_matlab/frame_'+string(c-95)+ '.png');
    disp(c)
end

%% Open sim log

Table = load(['../../../sim_log/sine_steer1.mat']);

u = Table.VehicleModel_VM_Outputs_States_u;
v = Table.VehicleModel_VM_Outputs_States_v;
yaw = Table.VehicleModel_VM_Outputs_States_yaw;
fl = Table.VehicleModel_VM_Outputs_AdditionalStates_delta_fl;
fr = Table.VehicleModel_VM_Outputs_AdditionalStates_delta_fr;

amp = [];
theta = [];

for c = 1:length(u)
    amp(end + 1) = sqrt((u(c) *u(c)) + ( v(c) * v(c)));
    theta(end + 1) = (fl(c) + fr(c))/2;
end

tit = 'Sine steer'

fig1 = figure;
tiledlayout(3, 1);

nexttile
plot(u);
subtitle("Longitudinal velocity")
ylabel('Velocity [m/s]')
xlabel('Time[ms]')
hold on
plot(amp, 'r');
hold on

t1 = title(tit);
t1.Visible = 'on';

nexttile
plot(v);
subtitle("Lateral velocity")
ylabel('Velocity [m/s]')
xlabel('Time[ms]')
hold on

nexttile
plot(fl);
hold on
plot(fr, 'r');
hold on
plot(theta, 'g');
subtitle("wheels fl/fr angle")
ylabel('Wheel angle [rad]')
xlabel('Time[ms]')

fig2 = figure;
tiledlayout(2, 1);

nexttile
plot(amp);
subtitle("Amplitude velocity vector")
ylabel('Velocity [m/s]')
xlabel('Time[ms]')
hold on

t1 = title(tit);
t1.Visible = 'on';

nexttile
plot(fr);
subtitle("Direction velocity vector")
ylabel('Velcoity angle [rad]')
xlabel('Time[ms]')
hold on
