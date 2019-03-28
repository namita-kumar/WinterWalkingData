%This script reads and stores kinematic and joint torquedata from
%Winter_Appendix_data.xlsx. The data can be found in
%D. Winter, Biomechanics and motor control of human movement, 
%4th ed. Hoboken, N.J.: Wiley, 2009.
%An excel spreadsheet containing this information can be found at
%http://www.dustynrobots.com/academia/research/
%winters-gait-data-in-excel-form/
%The original data is limited to 69 data points. So this script 
%interpolates to extend it to 100 data points.
%The interpolated angular position (rad), velocity (rad/s), and 
%joint torque (Nm) are stored as .mat files
clear; close all;
t_raw = xlsread('Winter_Appendix_data.xlsx',8,'A5:A73');
%reset start time to 0
t_raw = t_raw - t_raw(1);
%interpolated time
time = linspace(0,t_raw(end),100);
%read position data that is in deg
pos_raw = xlsread('Winter_Appendix_data.xlsx',8,'C5:E73')*pi/180;
%read position data that is in rad/s
vel_raw = xlsread('Winter_Appendix_data.xlsx',8,'F5:H73');
%read dynamic data that is in Nm
dyn_raw = xlsread('Winter_Appendix_data.xlsx',8,'I5:K73');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                Position                     %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot raw values
figure;
plot(t_raw,pos_raw,'o');
%interpolate position data
pos = interpolationfunction(t_raw,pos_raw,time);
%plot interpolated data 
hold on;
plot(time,pos,'-');
title('Angular position (rad)');
legend('Raw Ankle','Raw Knee','Raw Hip',...
    'Interpolated Ankle','Interpolated Knee','Interpolated Hip');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                Velocity                     %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot raw values
figure;
plot(t_raw,vel_raw,'o');
%interpolate position data
vel = interpolationfunction(t_raw,vel_raw,time);
%plot interpolated data 
hold on;
plot(time,vel,'-');
title('Angular velocity (rad/s)');
legend('Raw Ankle','Raw Knee','Raw Hip',...
    'Interpolated Ankle','Interpolated Knee','Interpolated Hip');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                 Torque                      %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot raw values
figure;
plot(t_raw,dyn_raw,'o');
%interpolate position data
dyn = interpolationfunction(t_raw,dyn_raw,time);
%plot interpolated data 
hold on;
plot(time,dyn,'-');
title('Angular velocity (rad/s)');
legend('Raw Ankle','Raw Knee','Raw Hip',...
    'Interpolated Ankle','Interpolated Knee','Interpolated Hip');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                Store data                   %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save pos
save vel
save dyn

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%          Interpolation function             %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [interpolated] = interpolationfunction(t_raw,data_raw,time)
    %create interpolated data for pos
    data_a = griddedInterpolant(t_raw,data_raw(:,1));
    data_k = griddedInterpolant(t_raw,data_raw(:,2));
    data_h = griddedInterpolant(t_raw,data_raw(:,3));
    %find interpolated values for 100 data set time vactor
    
    interpolated(:,1) = data_a(time);
    interpolated(:,2) = data_k(time);
    interpolated(:,3) = data_h(time);
end