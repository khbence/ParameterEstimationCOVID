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

sen1 = 'data_cont/maintain_all__';
sen2 = 'data_cont/maintain_all_but_curfew_';
sen3 = 'data_cont/maintain_all_but_5_';
sen4 = 'data_cont/maintain_all_but_curfew5_';
sen5 = 'data_cont/release_all_but22mask_';
sen6 = 'data_cont/release_all_but22_';

Strings = {sen1;sen2;sen3;sen4;sen5;sen6};

% Legend nevek megadása:

Scenarionames = {'Maszk+kijaras+5,6,22',
                 'Maszk+5,6,22',
                 'Maszk+kijaras+6,22',
                 'Maszk+6,22',
                 'Maszk+22',
                 '22'};
             
% Cím megadása:
             
Title = 'Jan 11 utáni korlátozások hatása. Kezdés: szept 23';

% Végül a függvény hívása:

plotterpp(Strings,Scenarionames,Title,1,0)
