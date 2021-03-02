close all; clear all; clc;
% Standard input:
std_ip = {'data/fullRerun/default/default_'}; std_flag = 0;
% Agentstat input:
agst_ip = {'data/defcont/datad/outAgent/default_outagent_'}; agst_flag = 0;
% Trace input:
tr_ip = {'data/defcont/datad/dumplist_'}; tr_flag = 1;
% Legend nevek megadása:
Scennames = {'Default'};
% Cím megadása:
title = 'Realistic simulation';
% Plot határok bejelölése:
measures = {{'Restr.'},49;
            {'Vacci.'},100};
% Kezdődátum megadása:
startd = '09/23/20'; % mm/dd/yy
% Mentett grafikonok helye:
path = 'data/defcont/res/default';
% Mérési adat flag:
m_flag = 0;
% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scennames,title,measures,startd,std_flag,agst_flag,tr_flag,m_flag,path);
clearvars agst_ip Scennames std_ip title tr_ip measures startd path std_flag agst_flag tr_flag m_flag