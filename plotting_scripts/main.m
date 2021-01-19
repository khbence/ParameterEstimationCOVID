close all; clear all; clc;

% Jelenleg így dolgozható fel a standard output:

% Data input megadása:

Strings = {'data/data0105/closureRules_from_jan5_nochange_',
           'data/data0105/closureRules_from_jan5_highschoolopennocurfew5open_',
           'data/data0105/closureRules_from_jan5_default_'};

% Legend nevek megadása:

Scenarionames = {'Nov. 11-ei korlátozás nélkül',
                 'Januári feloldással',
                 'Januári feloldás nélkül'};
             
% Cím megadása:
             
Title = 'Valami cim';

% Végül a függvény hívása:

plotterpp(Strings,[],[],Scenarionames,Title,1,0,0)
