close all; clear all; clc;

% Jelenleg így dolgozható fel a standard output:

% Data input megadása:

% Standard input:

std_ip = {'data/dataexample/outputs_01_18/q1_',
          'data/dataexample/outputs_01_18/q2_',
          'data/dataexample/outputs_01_18/q3_'};

% Agentstat input:
      
agst_ip = {'data/dataexample/outagent_01_18/outagent_q1_',
           'data/dataexample/outagent_01_18/outagent_q2_',
           'data/dataexample/outagent_01_18/outagent_q3_'};

% Legend nevek megadása:

Scenarionames = {'q1',
                 'q2',
                 'q3'};
             
% Cím megadása:
             
Title = 'Valami cim';

% Végül a függvény hívása:

plotterpp(std_ip,agst_ip,[],Scenarionames,Title,1,1,0)

