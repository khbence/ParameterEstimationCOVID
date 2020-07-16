%coronavirus epidemic model fit based on the data at:
%https://gisanddata.maps.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6

clear all
global alpha beta0 k2 k3 tm ym i0 r0 s0 e0 ci0 Np tf

Np = 60000000; %population of Italy lumped together

%load measurements
tmp=importdata('Italy_cor.txt'); %number of new infected people on each day in Italy
tmp=flip(tmp); %reverse data series to start from older date

%create cumulative number of infected people
ym=cumsum(tmp);

%ym=6*ym; %true number of infected



ym=ym/Np; %proportion of infected people
ym=ym';
N=length(ym);
tm=[0:N-1]; %daily measurements
tm=tm';

%assume that the true number of infected is higher than the measured (8-10, 40???)
y_scale=20;
ym = y_scale * ym;


%always the same initial conditions
s0=Np/Np - ym(1);
r0=0;
s0=Np/Np - ym(1);

%select method
method=1;

%time-varying infection probability is given by:
%k1(t) = -alpha*t + beta0


%optimization parameters:
%1. alpha: 	parameter 1 of the time varying infection probability
%2. beta0:	parameter 2 of the time varying infection probability
%3  i(0):	initial value of infected
%4  k2:		transition rate between e-infected and infected
%5  k3:		recovery rate

%initial values
p10 = 0.0121;
p20 = 0.5546; %from previous non-time-varying simulations
%p30 = 0.6663; %from previous non-time-varying simulations
p30 = 2.0795e-05; %from previous non-time-varying simulations
p40 = 1/5.1
p50 = 1/14


p10= 0.0121    
p20 = 0.5801    
p30 = 2.5079e-05   
p40= 0.1845    
p50 = 0.0962


p10 =  0.0119    
p20 = 0.5922    
p30 = 2.1153e-05  
p40 = 0.1864    
p50 = 0.0999


switch method
case 1
  %Simplex search
  
  %0.7806    0.5616  3.9808e-06
  
  %xinitial=[0.4631    0.3922    2e-6];
  %xinitial=[1   1    2e-6];
  xinitial = [p10 p20 p30 p40 p50];
  options=optimset('MaxFunEvals', 1000000, 'Display', 'iter', 'MaxIter', 500000);
  [Xopt, Vopt]=fminsearch('COR_objfun_I_SEIR', xinitial, options);

otherwise
  %patternsearch
  %xinitial=[b k i0];
  p10=0.0077;
  p20=0.3933;
  p30=3.0534;
  p40=4.8378e-06;
  
  lb=[0 0 0 0]; %lower bound
  %ub=[10 0.3 1000]; 
  ub=[100 100 100 100]; 
  xinitial = [p10 p20 p30 p40 p50];
  psoptions=psoptimset('Display', 'iter', 'MaxIter', 500000, 'MaxFunEvals', 1000000);
  [Xopt, Fopt]=patternsearch(@COR_objfun_I_SEIR, xinitial, [], [], [], [], lb, ub, [], psoptions)
end

COR_plot_res_I_SEIR;


