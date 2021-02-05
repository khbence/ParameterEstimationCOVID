close all; clear all; clc;

% Standard input:
% std_ip = {'data/dataexample/outputs_01_18/q1_',
%           'data/dataexample/outputs_01_18/q2_',
%           'data/dataexample/outputs_01_18/q3_'};
% std_ip = {'data/data0201/output_byrelation2_',
%           'data/data0201/output_government_',
%           'data/data0201/output_v_bydanger_'};
std_ip = {'data/data0203/outputs_02_03/standard_output_'};

% Agentstat input:     
% agst_ip = {'data/dataexample/outagent_01_18/outagent_q1_',
%            'data/dataexample/outagent_01_18/outagent_q2_',
%            'data/dataexample/outagent_01_18/outagent_q3_'};
agst_ip = {'data/data0203/outagent_02_03/outagent_'};
% Trace input:
% tr_ip = {'data/dataexample/dumplist_01_18/dumplist_q1_',
%          'data/dataexample/dumplist_01_18/dumplist_q2_',
%          'data/dataexample/dumplist_01_18/dumplist_q3_'};
tr_ip = {'data/data0203/dumplist_02_03/dumplist_'};
% Legend nevek megadása:
% Scenarionames = {'Critical workplaces order',
%                  'Gov-defined order',
%                  'Endangered order'};
Scenarionames = {'Gov-def. order'};
% Cím megadása:
Title = 'Goverment vaccination priority';

% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scenarionames,Title,1,0,0);

clearvars agst_ip Scenarionames std_ip Title tr_ip