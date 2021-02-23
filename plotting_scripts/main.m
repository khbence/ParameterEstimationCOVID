close all; clear all; clc;

% Standard input:
std_ip = {'data/article/default/default_',
          'data/article/testing_probability/testing_probability_10_times_more_random_',
          'data/article/testing_probability/testing_probability_10_times_more_home_',
          'data/article/testing_probability/testing_probability_10_times_more_workschool_',
          'data/article/testing_probability/testing_probability_10_times_more_hospital_nursing_home_'};
% Agentstat input:
agst_ip = {'data/article/default/outAgent/default_outagent_',
           'data/article/testing_probability/outAgent/testing_probability_10_times_more_random_outagent_',
           'data/article/testing_probability/outAgent/testing_probability_10_times_more_home_outagent_',
           'data/article/testing_probability/outAgent/testing_probability_10_times_more_workschool_outagent_',
           'data/article/testing_probability/outAgent/testing_probability_10_times_more_hospital_nursing_home_outagent_'};
% Trace input:
tr_ip = {'data/data0203/dumplist_02_03/dumplist_'};
% Legend nevek megadása:
Scenarionames = {'Default';'Random';'Home';'Work, school';'Hospital, nursery'};
% Cím megadása:
Title = 'More testing prob. simulations';
% Plot határok bejelölése:
Measures = {{'Restr.'},49;
            {'Vacci.'},96};
% Kezdődátum megadása:
StartDate = '09/23/20'; % mm/dd/yy
% Mentett grafikonok helye:
Path = 'data/plots/publication/testing_probability';

% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scenarionames,Title,Measures,StartDate,1,1,0,0,Path);

clearvars agst_ip Scenarionames std_ip Title tr_ip Measures StartDate Path