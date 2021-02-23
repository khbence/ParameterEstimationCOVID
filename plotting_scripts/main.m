close all; clear all; clc;

% Standard input:
std_ip = {'data/article/default/default_'};
% Agentstat input:
agst_ip = {'data/article/default/outAgent/default_outagent_'};
% Trace input:
tr_ip = {'data/data0203/dumplist_02_03/dumplist_'};
% Legend nevek megadása:
Scenarionames = {'Default'}; % Close infected classes: default
% Cím megadása:
Title = 'Default simulations';
% Plot határok bejelölése:
Measures = {{'Restr.'},49;
            {'Vacci.'},96};
% Kezdődátum megadása:
StartDate = '09/23/20'; % mm/dd/yy
% Mentett grafikonok helye:
Path = 'data/attempt/deftest';

% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scenarionames,Title,Measures,StartDate,0,1,0,0,Path);

clearvars agst_ip Scenarionames std_ip Title tr_ip Measures StartDate Path