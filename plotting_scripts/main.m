close all; clear all; clc;

% Standard input:
std_ip = {'data/fullRerun/default/default_',
          'data/fullRerun/closures_school_levels/school_closes_',
          'data/fullRerun/closures_school_levels/no_school_'};
% Agentstat input:
agst_ip = {'data/fullRerun/default/outAgent/default_outagent_',
           'data/fullRerun/closures_school_levels/outAgent/school_closes_outagent_',
           'data/fullRerun/closures_school_levels/outAgent/no_school_outagent_'};
% Trace input:
tr_ip = {'data/data0203/dumplist_02_03/dumplist_'};
% Legend nevek megadása:
Scenarionames = {'Close infected classes';'Close infected schools';'Close all schools'};
% Cím megadása:
Title = 'Educational simulations';
% Plot határok bejelölése:
Measures = {{'Restr.'},49;
            {'Vacci.'},96};
% Kezdődátum megadása:
StartDate = '09/23/20'; % mm/dd/yy
% Mentett grafikonok helye:
Path = 'data/attempt/schooltest';

% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scenarionames,Title,Measures,StartDate,0,1,0,0,Path);

clearvars agst_ip Scenarionames std_ip Title tr_ip Measures StartDate Path