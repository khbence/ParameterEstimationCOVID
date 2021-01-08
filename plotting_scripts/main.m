% A standard plotok előállításához a plotterpp(data, legend, title)
% függvényt kell használni.

% A data input egy string array, ami tartalmazza az elérési útvonalait a
% scenarioknak, illetve a fájl neveket a sorszám előttig, a függvény
% gyakorlatilag megkeresi az összes ilyen nevű fájlt és feldolgozza őket,
% legyen akármennyi futtatás egy scenario-ra (sajnos azt még nem szereti,
% ha csak 1 db futtatás van 1 scenario-ra). Fontos, hogy ezek txt-k
% legyenek, és kizárólag az ágens számokat tartalmazzák, egyéb más
% információkat (pl. iskola bezárás, záró sorok, stb.-t) ne, így kaptam az
% adatokat, erre készítettem fel a beolvasó függvényt. Látható, hogy
% fontos, hogy a fájlnevek a sorszámig, egyforma hosszúságúak legyenek, ez
% gond nélkül megadható a futtató script-ben.

% A legend input azonos dimenziójú string array, mint a data, ide azt kell
% írni, hogy milyen néven akarod, hogy egyes scenariok a ploton
% szerepeljenek. Ugyanazok a szabályok vonatkoznak rá, mint a data inputra,
% hogy egyforma méretű elemek kellenek, ez white space-szel könnyen
% megoldható.

% A title input egy szem string, ez azt állítja be, hogy a plotokon felett
% mi legyen a cím.

% Csatoltam egy mappát benne pár példaadattal, ez a kód jelen állapotában
% futtatható.

% Jelenleg a többi inputját, aki futtattja, hagyja figyelmen kívül, majd a
% teljes automatizáláshoz készültek flag-ek csak.

close all; clear all; clc;

% Data input megadása:

sen1 = 'data/data0105/closureRules_from_jan5_nochange_';
sen2 = 'data/data0105/closureRules_from_jan5_highschoolopennocurfew5open_';
sen3 = 'data/data0105/closureRules_from_jan5_default_';

Strings = {sen1;sen2;sen3};

% Legend nevek megadása:

Scenarionames = {'Nov. 11-ei korlátozás nélkül',
                 'Januári feloldással',
                 'Januári feloldás nélkül'};
             
% Cím megadása:
             
Title = 'Simulations starts from 23rd of September';

% Végül a függvény hívása:

plotterpp(Strings,Scenarionames,Title,1,0)
