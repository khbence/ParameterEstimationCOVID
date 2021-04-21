close all; clear all; clc;
% Standard input:
std_ip = {'sample_data/data/default_'}; std_flag = 1;
% Agentstat input:
agst_ip = {}; agst_flag = 0;
% Trace input:
tr_ip = {}; tr_flag = 0;
% Legends:
Scennames = {'Default'};
% Plot title:
title = 'Default scenario';
% Noting events on the time-series plots:
measures = {{'Restr.'},49;
            {'Vacci.'},100};
% Starting date (must be given in an agreement with begintint):
startd = '10/01/20'; % mm/dd/yy
% Path to the saved plots:
path = 'sample_data/result';
% Flag for measurement data:
m_flag = 1;
% Scenario colors:
colors = [[255 0 0];[0 255 0];[0 0 255];[0 0 0];[255 0 255];[0 255 255]];
% Intervals for AgentStat processing:
intervals = [0 100; 101 200; 201 300];
% First n point to be disregarded (must be given in an agreement with startd):
begintint = 8;
% Weighting flag for Rt (should be always zero, under development):
ctw_flag = 0;
% Calling the function to process the data:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scennames,title,measures,startd,std_flag,agst_flag,tr_flag,...
                          m_flag,path,colors,intervals,begintint,ctw_flag);
clearvars agst_ip Scennames std_ip title tr_ip measures startd path std_flag agst_flag tr_flag
clearvars m_flag colors intervals begintint ctw_flag