close all; clear all; clc;
% Standard input:
std_ip = {'data/defdata/default_'}; std_flag = 1;
% Agentstat input:
agst_ip = {'data/defdata/outAgent/default_'}; agst_flag = 0;
% Trace input:
tr_ip = {'data/data0203/dumplist_02_03/dumplist_'}; tr_flag = 0;
% Legend nevek megadása:
Scennames = {'Default'};
% Cím megadása:
title = 'Scenarios';
% Plot határok bejelölése:
measures = {{'Restr.'},49;
            {'Vacci.'},100};
% Kezdődátum megadása:
startd = '10/01/20'; % mm/dd/yy
% Mentett grafikonok helye:
path = 'data/result_default/default_1';
% Mérési adat flag:
m_flag = 1;
% Színek:
colors = [[255 0 0];[0 255 0];[0 0 255];[0 0 0];[255 0 255];[0 255 255]];
% Statisztikák intervallumai:
intervals = [0 100; 101 200; 201 300];
% Idősor ábrázolási kezdet:
begintint = 8;
% Standard statisztika nE/aI idősor súlyozás flag:
ctw_flag = 0;
% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scennames,title,measures,startd,std_flag,agst_flag,tr_flag,...
                          m_flag,path,colors,intervals,begintint,ctw_flag);
clearvars agst_ip Scennames std_ip title tr_ip measures startd path std_flag agst_flag tr_flag
clearvars m_flag colors intervals begintint ctw_flag