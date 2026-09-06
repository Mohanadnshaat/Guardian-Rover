clearvars;
clc;
close all;
%% voltage signal, from workspace
t = (0:0.01:10)';
v = [5*ones(300,1); linspace(5,0.5,400)'; 0.5*ones(301,1)];
Front_V_data = [t, v];

%% Bus data creator

elems(1) = Simulink.BusElement;
elems(1).Name = 'Sensor_Close'; elems(2).DataType = 'boolean';
elems(2) = Simulink.BusElement;
elems(2).Name = 'Sensor_Dist_out'; elems(1).DataType = 'double';
SensorDataBus = Simulink.Bus;
SensorDataBus.Elements = elems;

%%
% gains = [0.9 1.0 1.1];
% figure; hold on;
% for i = 1:numel(gains)
%     set_param('Robot_Project/Robot_sensor/Front_Gain_Calibration', 'Gain', num2str(gains(i)));
%     simOut = sim('Robot_Project');
%     logged = simOut.get('Front_Dist_log');
%     plot(logged.time, logged.signals.values, 'DisplayName', ['Gain = ' num2str(gains(i))]);
% end
% legend show; grid on; xlabel('Time (s)'); ylabel('Front Distance (cm)');
% set_param('Robot_Project/Robot_sensor/Front_Gain_Calibration', 'Gain', '1.0');  % reset to default