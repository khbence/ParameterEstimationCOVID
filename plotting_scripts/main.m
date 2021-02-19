close all; clear all; clc;

% Standard input:
std_ip = {'data/data0203/outputs_02_03/standard_output_'};
% Agentstat input:
agst_ip = {'data/data0203/outagent_02_03/outagent_'};
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

% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scenarionames,Title,Measures,StartDate,1,1,1,1);

clearvars agst_ip Scenarionames std_ip Title tr_ip Measures StartDate