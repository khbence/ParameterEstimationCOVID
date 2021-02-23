close all; clear all; clc;

% Standard input:
std_ip = {'data/article/default/default_',
          'data/article/closures_school_level/school_closes_',
          'data/article/closures_school_level/no_school_'};
% Agentstat input:
agst_ip = {'data/article/default/outAgent/default_outagent_',
           'data/article/closures_school_level/outAgent/school_closes_outagent_',
           'data/article/closures_school_level/outAgent/no_school_outagent_'};
% Trace input:
tr_ip = {'data/data0203/dumplist_02_03/dumplist_'};
% Legend nevek megadása:
Scenarionames = {'Close infected classes',' Close infected schools','Close all schools'}; % Close infected classes: default
% Cím megadása:
Title = 'Educational simulations';
% Plot határok bejelölése:
Measures = {{'Restr.'},49;
            {'Vacci.'},96};
% Kezdődátum megadása:
StartDate = '09/23/20'; % mm/dd/yy
% Mentett grafikonok helye:
Path = 'data/plots/publication/closures_school_level_repro';

% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scenarionames,Title,Measures,StartDate,1,0,0,0,Path);

clearvars agst_ip Scenarionames std_ip Title tr_ip Measures StartDate Path