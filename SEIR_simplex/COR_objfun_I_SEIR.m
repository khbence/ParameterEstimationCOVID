function out=COR_objfun_I_SEIR(p)
global alpha beta0 k2 k3 tm ym i0 r0 s0 e0 ci0 Np tf

%input decision variable:
%x(1): b
%x(2): k
%x(3): i0 (initial value of infected)

alpha=p(1);
beta0=p(2);

 
%varying initial conditions
i0=p(3);
e0=20*i0;
ci0=i0;
k2=p(4);
k3=p(5);


x0=[s0; e0; i0; r0; ci0];
tf=tm(length(tm));
tspan=[0 tf];
[t,x]=ode45(@COR_sim_ode_opt_I_SEIR, tspan, x0);

x5=x(:,5);
x5m=interp1(t,x5,tm);
x5m=x5m';





%% DEBUG - BEGIN
%size(x5m)
%size(ym)
%tmp=x5m-ym;
%plot(tm,x5m,'b-');
%hold on
%plot(tm,ym,'r-')
%plot(tm,x5m-ym,'g-')
%hold off
%pause
%% DEBUG - END


errnorm=norm((x5m-ym),2); %error is the 2-norm

%terminal penalty
tmp=length(ym);
wp=100; %weighting
term_pen=wp*(abs(x5m(tmp)-ym(tmp)) + abs(x5m(tmp-1)-ym(tmp-1)));

%R0 cannot be negative
if (beta0-alpha*tf) < 0.01
  errnorm = 1000000;
end

%set k2 to be feasible
if k2 < 1/6 || k2 > 1/3
  errnorm = 1000000;
end

%set k3 (recovery) to be feasible
if k3 > 1/10 || k3 < 1/16
  errnorm = 1000000;
end



%out=100*errnorm + term_pen;
out=100*errnorm;