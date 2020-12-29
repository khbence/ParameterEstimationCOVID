close all; clear all; clc;

output = contactr0fun('data1110/infectiouslist_11_10/11_10_infectiousList_','data1110/outagent_11_10/outagent_11_10.json');

var = output.eloszlas(:,2);

figure;
histogram(var)
idx = var > 0;
figure;
histogram(var(idx))


% close all; clear all; clc;
% 
output = contacttracer('data1110/infectiouslist_11_10/11_10_infectiousList_','data1110/outagent_11_10/outagent_11_10.json');



average = output.average;
maximums = output.maximuminfections;

writematrix(average,'ctaverage.csv');
writematrix(maximums,'ctmaximums.csv');

t = 0:length(average)-1;

figure
plot(t,9.52*average,'LineWidth',1.5)
xlim([0 length(average)-1])
xlabel('Time [days]')
ylabel('Infections')
title('Average infections per capita per day')
figure
plot(t,maximums,'LineWidth',1.5)
xlim([0 length(average)-1])
xlabel('Time [days]')
title('Record infections per day')
ylabel('Infections')