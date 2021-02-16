close all; clear all; clc;

% Standard input:
std_ip = {'data/data0203/outputs_02_03/standard_output_'};
% Agentstat input:
agst_ip = {'data/data0203/outagent_02_03/outagent_'};
% Trace input:
tr_ip = {'data/data0203/dumplist_02_03/dumplist_'};
% Legend nevek megadása:
Scenarionames = {'Gov-def. order'};
% Cím megadása:
Title = 'Goverment vaccination priority';
% Plot határok bejelölése:
Measures = {{'Kij. korl.','Nov. 11.'},7;
            {'Oltás','Dec. 6.'},63};
% Kezdődátum megadása:
StartDate = '12/12/20';

% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scenarionames,Title,Measures,StartDate,1,0,0,1);

clearvars agst_ip Scenarionames std_ip Title tr_ip Measures