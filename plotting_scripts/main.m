close all; clear all; clc;

% Standard input:
std_ip = {'data/article/default/default_'};
% Agentstat input:
agst_ip = {'data/article/default/outAgent/default_outagent_'};
% Trace input:
tr_ip = {'data/data0203/dumplist_02_03/dumplist_'};
% Legend nevek megadása:
Scenarionames = {'Default'};
% Cím megadása:
Title = 'Default simulation';
% Plot határok bejelölése:
Measures = {{'Restr.','Nov. 11.'},49;
            {'Vacci.','Dec. 28.'},96};
% Kezdődátum megadása:
StartDate = '09/23/20'; % mm/dd/yy
% Mentett grafikonok helye:
Path = 'data/plots/publication/default';

% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scenarionames,Title,Measures,StartDate,1,1,0,1,Path);

clearvars agst_ip Scenarionames std_ip Title tr_ip Measures StartDate