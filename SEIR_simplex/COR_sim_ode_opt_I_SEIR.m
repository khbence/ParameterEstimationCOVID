function out = COR_sim_ode_opt_I_SEIR(t,x)
global alpha beta0 k2 k3 tm ym i0 r0 s0 e0 ci0 Np tf

s=x(1); e=x(2); i=x(3); r=x(4); ci=x(5);

%the time-varying infection rate:
if t < tf
  k1 = -alpha * t + beta0; %it is assumed to decrease until tf
else
  k1 = -alpha * tf + beta0;
end

tmp1 = -k1*s*i; 	%susceptible (S)
tmp2 = k1*s*i - k2*e;	%pre-infected (E)
tmp3 = -k3*i + k2*e;	%infected (I)
tmp4 = k3*i;		%recovered (R)
tmp5 = k2*e;		%cumulative infected (CI)

out=[tmp1; tmp2; tmp3; tmp4; tmp5];
