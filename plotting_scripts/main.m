close all; clear all; clc;
% Standard input:
std_ip = {'data/fullRerun/default/default_',
          'data/fullRerun/closures_school_levels/school_closes_',
          'data/fullRerun/closures_school_levels/no_school_'}; std_flag = 1;
% Agentstat input:
agst_ip = {'data/fullRerun/default/outAgent/default_outagent_',
           'data/fullRerun/closures_school_levels/outAgent/school_closes_outagent_',
           'data/fullRerun/closures_school_levels/outAgent/no_school_outagent_'}; agst_flag = 0;
% Trace input:
tr_ip = {'data/data0203/dumplist_02_03/dumplist_'}; tr_flag = 0;
% Legend nevek megadása:
Scennames = {'Close infected classes';'Close infected schools';'Close all schools'};
% Cím megadása:
Title = 'Educational simulations';
% Plot határok bejelölése:
Measures = {{'Restr.'},49;
            {'Vacci.'},96};
% Kezdődátum megadása:
StartD = '09/23/20'; % mm/dd/yy
% Mentett grafikonok helye:
Path = 'data/attempt/schooltest4';
% Mérési adat flag:
m_flag = 0;
% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scennames,Title,Measures,StartD,std_flag,agst_flag,tr_flag,m_flag,Path);
clearvars agst_ip Scennames std_ip Title tr_ip Measures StartD Path std_flag agst_flag tr_flag m_flag