close all; clear all; clc;
% Standard input:
std_ip = {'data/agtyptest/agentType_0302_test_',
          'data/agtyptest/aagentType_0305_test_',
          'data/agtyptest/agentType_0305_test_testingP_50percent_higher_',
          'data/agtyptest/agentType_0305_test_testingP_100percent_higher_',
          'data/agtyptest/agentType_0305_test_testingP_150percent_higher_'}; std_flag = 1;
% Agentstat input:
agst_ip = {'data/fullRerun/default/outAgent/default_outagent_'}; agst_flag = 0;
% Trace input:
tr_ip = {'data/data0203/dumplist_02_03/dumplist_'}; tr_flag = 0;
% Legend nevek megadása:
Scennames = {'03.02.';'03.05. with default testingP';'03.05. with 50% higher testingP';'03.05. with 100% higher testingP';'03.05. with 150% higher testingP'};
% Cím megadása:
title = 'Agenttype test';
% Plot határok bejelölése:
measures = {{'Restr.'},49;
            {'Vacci.'},100};
% Kezdődátum megadása:
startd = '10/01/20'; % mm/dd/yy
% Mentett grafikonok helye:
path = 'data/agenttest';
% Mérési adat flag:
m_flag = 1;
% Színek:
colors = [[255 0 0];[0 255 0];[0 0 255];[0 0 0];[255 0 255];[0 255 255]];
% Statisztikák intervallumai:
intervals = [0 100; 101 200; 201 300];
% Idősor ábrázolási kezdet:
begintint = 8;
% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scennames,title,measures,startd,std_flag,agst_flag,tr_flag,m_flag,path,colors,intervals,begintint);
clearvars agst_ip Scennames std_ip title tr_ip measures startd path std_flag agst_flag tr_flag m_flag colors intervals begintint