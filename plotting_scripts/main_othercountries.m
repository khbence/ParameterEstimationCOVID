close all; clear all; clc;
% Standard input:

 std_ip = {
      'data_new32/bulgaria/BGR_test1_moretest0.5x_';
      'data_new32/denmark/DNK_test1_moretests20x_';
      'data_new32/portugal/PRT_test1_moretests2x_';

          };
    %'data/agtyptest/agentType_0302_test_',
    %      'data/agtyptest/aagentType_0305_test_',
    %      'data/agtyptest/agentType_0305_test_testingP_50percent_higher_',
    %      'data/agtyptest/agentType_0305_test_testingP_100percent_higher_',
    %      'data/agtyptest/agentType_0305_test_testingP_150percent_higher_'};
    std_flag = 1;
% Agentstat input:
agst_ip = {'data_new21/default/outAgent/default_'}; agst_flag = 0;%;'data_new21/freespread/outAgent/default_outagent_'
% Trace input:
tr_ip = {'data/data0203/dumplist_02_03/dumplist_'}; tr_flag = 0;
% Legend nevek megadása:
 Scennames = {
     'bulgaria';
     'denmark';
     'portugal';
    };%;'03.05. with 50% higher testingP';'03.05. with 100% higher testingP';'03.05. with 150% higher testingP'};
% Cím megadása:
%title = 'Vaccine efficiency vs. infection - QP2, 90% vs. hospitalization, Qvacc';
%title = 'Vaccine efficiency vs. hospitalization - QP2, 65% vs. infection, Qvacc';
%title = 'Vaccine efficiency vs. infection and QP2 vs QP3, 90% vs. hospitalization, Qvacc';
%title = 'Fraction of population vaccinated - QP2 vs. QP3, vaccines 65% vs. infection, 90% vs. hospitalization, Qvacc';
%title = 'Quarantining the vaccinated - QP2 vs. QP3, vaccines 65% vs. infection, 90% vs. hospitalization';
%title = 'Effect of reinfection - QP2 vs. QP3, 65% vs. infection, 90% vs. hospitalization';
% title = 'Delta fit';
title = 'Other countries';
% Plot határok bejelölése:
measures = {{'2020 nov 11'},49;
            {'Oltások'},96;
            {'Emlékeztető oltások'},315};
% Kezdődátum megadása:
startd = '10/01/20'; % mm/dd/yy
% Mentett grafikonok helye:
%path = 'data/0711_vaccineCount_qp2_qp3_65%_90%';
path = 'data/0111_other';
% Mérési adat flag:
m_flag = 0;
% Színek:
colors = [[255 0 0];[0 255 0];[0 0 255];[0 0 0];[255 0 255];[0 255 255];[255 255 0];[128 128 128];[128 0 128];[0 128 128]];
% Statisztikák intervallumai:
intervals = [0 114; 115 360];
% Idősor ábrázolási kezdet:
begintint = 8;
% Standard statisztika nE/aI idősor súlyozás flag:
ctw_flag = 0;
% Végül a függvény hívása:
output = fun_plotter_main(std_ip,agst_ip,tr_ip,Scennames,title,measures,startd,std_flag,agst_flag,tr_flag,...
                          m_flag,path,colors,intervals,begintint,ctw_flag);
clearvars agst_ip Scennames std_ip title tr_ip measures startd path std_flag agst_flag tr_flag
clearvars m_flag colors intervals begintint ctw_flag