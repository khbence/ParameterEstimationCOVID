close all; clear all; clc;

% Standard input:
std_ip = {'data_new3/all_m1.6__'};
% Agentstat input:
agst_ip = {};%'data/data0203/outagent_02_03/outagent_'};
% Trace input:
tr_ip = {};%'data/data0203/dumplist_02_03/dumplist_'};
% Legend nevek megadása:
Scenarionames = {'1.6x'};
% Cím megadása:
Title = 'Goverment vaccination priority';
% Plot határok bejelölése:
Measures = {"Kij. korl.",49;
            "Oltás",105};

% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scenarionames,Title,Measures,1,0,0);

clearvars agst_ip Scenarionames std_ip Title tr_ip Measures