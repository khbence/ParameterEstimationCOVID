clear all; close all; clc;

fname = 'locationTypes.json';
locationtype = jsondecode(fileread(fname));
locationtypes = locationtype.types;
locationtype = rmfield(locationtype, 'types');
fname = 'agentTypes.json';
agenttypes = jsondecode(fileread(fname));
agenttypes = agenttypes.types;

AgentStat1 = agentcounter('data1123/outagent_11_23/11_23_q1_testdefa_antigen_16_outagent.json');
%AgentStat1 = agentcounter('data1101/qpolicy_11_01_outagent/outagent_peldaoutputquaranten2_21.json');
%AgentStat2 = agentcounter('data1101/qpolicy_11_01_outagent/outagent_peldaoutputquaranten0_12.json');
%AgentStat3 = agentcounter('data1101/qpolicy_11_01_outagent/outagent_peldaoutputquaranten0_13.json');
%AgentStat4 = agentcounter('data1101/qpolicy_11_01_outagent/outagent_peldaoutputquaranten0_14.json');
%AgentStat5 = agentcounter('data1101/qpolicy_11_01_outagent/outagent_peldaoutputquaranten0_15.json');


clearvars fname

%%

var = [AgentStat1.age AgentStat2.age AgentStat3.age AgentStat4.age AgentStat5.age];

AgentStatmat.age.av = mean(var,2);
AgentStatmat.age.stdev = std(var,0,2);

var = [AgentStat1.precond AgentStat2.precond AgentStat3.precond AgentStat4.precond AgentStat5.precond];

AgentStatmat.precond.av = mean(var,2);
AgentStatmat.precond.stdev = std(var,0,2);

var = [AgentStat1.sex AgentStat2.sex AgentStat3.sex AgentStat4.sex AgentStat5.sex];

AgentStatmat.sex.av = mean(var,2);
AgentStatmat.sex.stdev = std(var,0,2);

var = [AgentStat1.agenttype AgentStat2.agenttype AgentStat3.agenttype AgentStat4.agenttype AgentStat5.agenttype];

AgentStatmat.agenttype.av = mean(var,2);
AgentStatmat.agenttype.stdev = std(var,0,2);

var = [AgentStat1.worststate AgentStat2.worststate AgentStat3.worststate AgentStat4.worststate AgentStat5.worststate];

AgentStatmat.worststate.av = mean(var,2);
AgentStatmat.worststate.stdev = std(var,0,2);

var = [AgentStat1.locationtype AgentStat2.locationtype AgentStat3.locationtype AgentStat4.locationtype AgentStat5.locationtype];

AgentStatmat.locationtype.av = mean(var,2);
AgentStatmat.locationtype.stdev = std(var,0,2);

max1 = length(AgentStat1.infectiontimes);
max2 = length(AgentStat2.infectiontimes);
max3 = length(AgentStat3.infectiontimes);
max4 = length(AgentStat4.infectiontimes);
max5 = length(AgentStat5.infectiontimes);

maxars = [max1 max2 max3 max4 max5];
maxar = max(maxars);

var1 = [AgentStat1.infectiontimes; zeros(maxar-max1,1)];
var2 = [AgentStat2.infectiontimes; zeros(maxar-max2,1)];
var3 = [AgentStat3.infectiontimes; zeros(maxar-max3,1)];
var4 = [AgentStat4.infectiontimes; zeros(maxar-max4,1)];
var5 = [AgentStat5.infectiontimes; zeros(maxar-max5,1)];

var = [var1 var2 var3 var4 var5];

AgentStatmat.infectiontimes.av = mean(var,2);
AgentStatmat.infectiontimes.stdev = std(var,0,2);

var = [AgentStat1.infections AgentStat2.infections AgentStat3.infections AgentStat4.infections AgentStat5.infections];

AgentStatmat.infections.av = mean(var,2);
AgentStatmat.infections.stdev = std(var,0,2);

max1 = length(AgentStat1.diagnosistimes);
max2 = length(AgentStat2.diagnosistimes);
max3 = length(AgentStat3.diagnosistimes);
max4 = length(AgentStat4.diagnosistimes);
max5 = length(AgentStat5.diagnosistimes);

maxars = [max1 max2 max3 max4 max5];
maxar = max(maxars);

var1 = [AgentStat1.diagnosistimes; zeros(maxar-max1,1)];
var2 = [AgentStat2.diagnosistimes; zeros(maxar-max2,1)];
var3 = [AgentStat3.diagnosistimes; zeros(maxar-max3,1)];
var4 = [AgentStat4.diagnosistimes; zeros(maxar-max4,1)];
var5 = [AgentStat5.diagnosistimes; zeros(maxar-max5,1)];

var = [var1 var2 var3 var4 var5];

AgentStatmat.diagnosistimes.av = mean(var,2);
AgentStatmat.diagnosistimes.stdev = std(var,0,2);

var = [AgentStat1.diagnosises AgentStat2.diagnosises AgentStat3.diagnosises AgentStat4.diagnosises AgentStat5.diagnosises];

AgentStatmat.diagnosises.av = mean(var,2);
AgentStatmat.diagnosises.stdev = std(var,0,2);

clearvars AgentStat1 AgentStat2 AgentStat3 AgentStat4 AgentStat5 max1 max2 max3 max4 max5 maxar maxars var var1 var2 var3 var4 var5

%%

AgentStat1 = agentcounter('data1101/qpolicy_11_01_outagent/outagent_peldaoutputquaranten1_16.json');
AgentStat2 = agentcounter('data1101/qpolicy_11_01_outagent/outagent_peldaoutputquaranten1_17.json');
AgentStat3 = agentcounter('data1101/qpolicy_11_01_outagent/outagent_peldaoutputquaranten1_18.json');
AgentStat4 = agentcounter('data1101/qpolicy_11_01_outagent/outagent_peldaoutputquaranten1_19.json');
AgentStat5 = agentcounter('data1101/qpolicy_11_01_outagent/outagent_peldaoutputquaranten1_20.json');
fname = 'locationTypes.json';
locationtype = jsondecode(fileread(fname));
locationtypes = locationtype.types;
locationtype = rmfield(locationtype, 'types');
fname = 'agentTypes.json';
agenttypes = jsondecode(fileread(fname));
agenttypes = agenttypes.types;

clearvars fname

%%

var = [AgentStat1.age AgentStat2.age AgentStat3.age AgentStat4.age AgentStat5.age];

AgentStatmat2.age.av = mean(var,2);
AgentStatmat2.age.stdev = std(var,0,2);

var = [AgentStat1.precond AgentStat2.precond AgentStat3.precond AgentStat4.precond AgentStat5.precond];

AgentStatmat2.precond.av = mean(var,2);
AgentStatmat2.precond.stdev = std(var,0,2);

var = [AgentStat1.sex AgentStat2.sex AgentStat3.sex AgentStat4.sex AgentStat5.sex];

AgentStatmat2.sex.av = mean(var,2);
AgentStatmat2.sex.stdev = std(var,0,2);

var = [AgentStat1.agenttype AgentStat2.agenttype AgentStat3.agenttype AgentStat4.agenttype AgentStat5.agenttype];

AgentStatmat2.agenttype.av = mean(var,2);
AgentStatmat2.agenttype.stdev = std(var,0,2);

var = [AgentStat1.worststate AgentStat2.worststate AgentStat3.worststate AgentStat4.worststate AgentStat5.worststate];

AgentStatmat2.worststate.av = mean(var,2);
AgentStatmat2.worststate.stdev = std(var,0,2);

var = [AgentStat1.locationtype AgentStat2.locationtype AgentStat3.locationtype AgentStat4.locationtype AgentStat5.locationtype];

AgentStatmat2.locationtype.av = mean(var,2);
AgentStatmat2.locationtype.stdev = std(var,0,2);

max1 = length(AgentStat1.infectiontimes);
max2 = length(AgentStat2.infectiontimes);
max3 = length(AgentStat3.infectiontimes);
max4 = length(AgentStat4.infectiontimes);
max5 = length(AgentStat5.infectiontimes);

maxars = [max1 max2 max3 max4 max5];
maxar = max(maxars);

var1 = [AgentStat1.infectiontimes; zeros(maxar-max1,1)];
var2 = [AgentStat2.infectiontimes; zeros(maxar-max2,1)];
var3 = [AgentStat3.infectiontimes; zeros(maxar-max3,1)];
var4 = [AgentStat4.infectiontimes; zeros(maxar-max4,1)];
var5 = [AgentStat5.infectiontimes; zeros(maxar-max5,1)];

var = [var1 var2 var3 var4 var5];

AgentStatmat2.infectiontimes.av = mean(var,2);
AgentStatmat2.infectiontimes.stdev = std(var,0,2);

var = [AgentStat1.infections AgentStat2.infections AgentStat3.infections AgentStat4.infections AgentStat5.infections];

AgentStatmat2.infections.av = mean(var,2);
AgentStatmat2.infections.stdev = std(var,0,2);

max1 = length(AgentStat1.diagnosistimes);
max2 = length(AgentStat2.diagnosistimes);
max3 = length(AgentStat3.diagnosistimes);
max4 = length(AgentStat4.diagnosistimes);
max5 = length(AgentStat5.diagnosistimes);

maxars = [max1 max2 max3 max4 max5];
maxar = max(maxars);

var1 = [AgentStat1.diagnosistimes; zeros(maxar-max1,1)];
var2 = [AgentStat2.diagnosistimes; zeros(maxar-max2,1)];
var3 = [AgentStat3.diagnosistimes; zeros(maxar-max3,1)];
var4 = [AgentStat4.diagnosistimes; zeros(maxar-max4,1)];
var5 = [AgentStat5.diagnosistimes; zeros(maxar-max5,1)];

var = [var1 var2 var3 var4 var5];

AgentStatmat2.diagnosistimes.av = mean(var,2);
AgentStatmat2.diagnosistimes.stdev = std(var,0,2);

var = [AgentStat1.diagnosises AgentStat2.diagnosises AgentStat3.diagnosises AgentStat4.diagnosises AgentStat5.diagnosises];

AgentStatmat2.diagnosises.av = mean(var,2);
AgentStatmat2.diagnosises.stdev = std(var,0,2);

clearvars AgentStat1 AgentStat2 AgentStat3 AgentStat4 AgentStat5 max1 max2 max3 max4 max5 maxar maxars var var1 var2 var3 var4 var5

%%

NewMat.age = [AgentStatmat.age.av AgentStatmat2.age.av];
NewMat.precond = [AgentStatmat.precond.av AgentStatmat2.precond.av];
NewMat.sex = [AgentStatmat.sex.av AgentStatmat2.sex.av];
NewMat.agenttype = [AgentStatmat.agenttype.av AgentStatmat2.agenttype.av];
NewMat.worststate = [AgentStatmat.worststate.av AgentStatmat2.worststate.av];
NewMat.locationtype = [AgentStatmat.locationtype.av AgentStatmat2.locationtype.av];
NewMat.infections = [AgentStatmat.infections.av AgentStatmat2.infections.av];
NewMat.diagnosises = [AgentStatmat.diagnosises.av AgentStatmat2.diagnosises.av];
NewMat.infectiontimes = [[AgentStatmat.infectiontimes.av;zeros(18,1)] AgentStatmat2.infectiontimes.av];
NewMat.diagnosistimes = [[AgentStatmat.diagnosistimes.av;zeros(12,1)] AgentStatmat2.diagnosistimes.av];

%%

figure('Name','Plots1','NumberTitle','off')

subplot(2,3,1)
bar_age = categorical({'0-9','10-19','20-29','30-39','40-49','50-59','60-69','70-79','80-89','90-99'});
bar_age = reordercats(bar_age,{'0-9','10-19','20-29','30-39','40-49','50-59','60-69','70-79','80-89','90-99'});
h = bar(bar_age,NewMat.age);
set(h, {'DisplayName'}, {'q0','q1'}')
legend('Location','best')
xlabel('Age intervals [years]')
ylabel('Number of agents')
title('Age group distr. of the inf. population')

subplot(2,3,2)
bar_precond = categorical({'Healthy','Diabetes','CV','Chronickidney','COP'});
bar_precond = reordercats(bar_precond,{'Healthy','Diabetes','CV','Chronickidney','COP'});
h = bar(bar_precond,NewMat.precond);
set(h, {'DisplayName'}, {'q0','q1'}')
legend('Location','best')
ylabel('Number of agents')
title('Precond. distr. of the inf. population')

subplot(2,3,3)
bar_sex = categorical({'Female','Male'});
bar_sex = reordercats(bar_sex,{'Female','Male'});
h = bar(bar_sex,NewMat.sex);
set(h, {'DisplayName'}, {'q0','q1'}')
legend('Location','best')
ylabel('Number of agents')
title('Sex distr. of the inf. population')

subplot(2,3,4)
bar_worststate = categorical({'E','I_1','I_2','I_3','I_4','I_{5,h}','I_{6,h}','D'});
bar_worststate = reordercats(bar_worststate,{'E','I_1','I_2','I_3','I_4','I_{5,h}','I_{6,h}','D'});
var = NewMat.worststate;
var(10,:) = var(1,:);
var(1:2,:) = [];
h = bar(bar_worststate,var);
set(h, {'DisplayName'}, {'q0','q1'}')
legend('Location','best')
ylabel('Number of agents')
title('State distr.')

subplot(2,3,5)
bar_infections = categorical({'Infected','Not infected'});
bar_infections = reordercats(bar_infections,{'Infected','Not infected'});
h = bar(bar_infections,NewMat.infections);
set(h, {'DisplayName'}, {'q0','q1'}')
legend('Location','best')
ylabel('Number of agents')
title('Infected - Not infected agents')

subplot(2,3,6)
bar_diagnosises = categorical({'Diagnosed','Not diagnosed'});
bar_diagnosises = reordercats(bar_diagnosises,{'Diagnosed','Not diagnosed'});
h = bar(bar_diagnosises,NewMat.diagnosises);
set(h, {'DisplayName'}, {'q0','q1'}')
legend('Location','best')
ylabel('Number of agents')
title('Diagnosed - Not diagnosed agents')

figure('Name','Plots2','NumberTitle','off')

domain = (0:length(NewMat.infectiontimes)-1)';

subplot(2,1,1)
plot(domain,NewMat.infectiontimes,'LineWidth',1.5)
xlabel('Time [days]')
ylabel('Number of agents')
legend('q0','q1','Location','best')
title('Number of infections in a day')

subplot(2,1,2)
plot(domain,NewMat.diagnosistimes,'LineWidth',1.5)
xlabel('Time [days]')
ylabel('Number of agents')
legend('q0','q1','Location','best')
title('Number of diagnoses in a day')

figure('Name','Plots3','NumberTitle','off')

subplot(2,1,1)
bar_agenttype = categorical({'Infant','Kindergarten','Elementary school','High school','Full-time','Afternoon shift','Home office','Tourist'});
bar_agenttype = reordercats(bar_agenttype,{'Infant','Kindergarten','Elementary school','High school','Full-time','Afternoon shift','Home office','Tourist'});
var = NewMat.agenttype;
var(5,:) = [];
h = bar(bar_agenttype,var);
set(h, {'DisplayName'}, {'q0','q1'}')
legend('Location','best')
ylabel('Number of agents')
title('Agent type distribution of the infected population')

subplot(2,1,2)
bar_locationtype = categorical({'Residence','Public education','Full-time work place','Small social site','Large social site','Short visiting site','Long visiting site','Weekend social sites','Recreational sites','Closed facility','Hospital','Non-standard workplace','Health center','Classroom'});
bar_locationtype = reordercats(bar_locationtype,{'Residence','Public education','Full-time work place','Small social site','Large social site','Short visiting site','Long visiting site','Weekend social sites','Recreational sites','Closed facility','Hospital','Non-standard workplace','Health center','Classroom'});
var = NewMat.locationtype;
var(1,:) = [];
h = bar(bar_locationtype,var);
set(h, {'DisplayName'}, {'q0','q1'}')
legend('Location','best')
ylabel('Number of agents')
title('Location type distribution of the infected population')

clearvars bar_age bar_agenttype bar_diagnosises bar_infections bar_locationtype bar_precond bar_sex bar_worststate domain h var