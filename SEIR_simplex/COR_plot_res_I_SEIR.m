alpha=Xopt(1);
beta0=Xopt(2);
i0=Xopt(3);
ci0=i0;
k2=Xopt(4);
k3=Xopt(5);


x0=[s0; e0; i0; r0; ci0];
tf=tm(length(tm));
tspan=[0 5*tf];
[t,x]=ode45(@COR_sim_ode_opt_I_SEIR, tspan, x0);

figure 
plot(t,x(:,5),'r-', 'LineWidth', 2)
legend('model predicted')
xlabel('time [day] (starting date: Feb. 22)')
ylabel('cumulative infected (proportion of population)')
grid

print('Fig_01_I','-dpdf')
%print -depsc 'cor_fit1.eps'

y_max=max(ym);

figure
plot(tm,ym,'b-', 'LineWidth', 2)
hold on
plot(t,x(:,5),'r-', 'LineWidth', 2)
legend('Measured', 'Model computed')
grid
xlabel('time [day] (starting date: Feb. 22)')
ylabel('cumulative infected (proportion of population)')
axis([0 tf 0 y_max])
hold off

print('Fig_02_I','-dpdf')
%print -depsc 'cor_fit2.eps'


figure
plot(t, x,'Linewidth', 2)
legend('susceptible', 'e-infected', 'infected', 'recovered', 'cumulative inf.')
grid
xlabel('time [day] (starting date: Feb. 22)')
ylabel('proportion of population')

print('Fig_03_I','-dpdf')
%print -depsc 'cor_fit3.eps'


%check all population
all_pop=x(:,1)+x(:,2)+x(:,3)+x(:,4);
figure
plot(t,all_pop)
grid
xlabel('time [day] (starting date: Feb. 22)')
ylabel('proportion of population')


print('Fig_04_I','-dpdf')


xs=x(:,2:5);
figure
%title('Epidemic simulation results')
plot(tm,ym,'b-', 'LineWidth', 2)
hold on
%plot(t, x(:,2), 'r-', 'LineWidth', 2)
%plot(t, x(:,3), 'm-', 'LineWidth', 2)
%plot(t, x(:,4), 'c-', 'LineWidth', 2)
%plot(t, x(:,5), 'g-', 'LineWidth', 2)


plot(t, xs,'Linewidth', 2)
legend('measured cumul. inf.', 'sim. exposed', 'sim. infected', 'sim. recovered', 'sim. cumul. inf.')
hold on
xlabel('time [day] (starting date: Feb. 22, 220)')
ylabel('proportion of population')
grid
hold off



%plot infected separately
%figure
%plot(t, x(:,3),'LineWidth', 2)
%legend('infected')
%grid
%xlabel('time [day] (starting date: Feb. 22)')
%ylabel('proportion of population')

%print('Fig_05_I','-dpdf')

%plot number of infected people
%figure
%plot(t, x(:,3)*Np,  'LineWidth', 2)
%legend('infected')
%grid
%xlabel('time [day] (starting date: Feb. 22)')
%ylabel('number of infected people')

%print('Fig_06_I','-dpdf')

%plot cumulative number of infected people
%figure
%plot(t, x(:,4)*Np,  'LineWidth', 2)
%legend('infected')
%grid
%xlabel('time [day] (starting date: Feb. 22)')
%ylabel('cumulative number of infected people')

%print('Fig_07_I','-dpdf')


%compute and plot predicted daily number of new cases
%td=[0:tspan(length(tspan))];
%x4=x(:,4)*Np;
%x4d=interp1(t,x4,td);

%Nx=length(x4d);
%x4_new=zeros(Nx,1);

%for i=2:Nx
%  x4_new(i)=x4d(i)-x4d(i-1);

%end


%figure
%stem(td,x4_new)


%figure
%plot(t,(x(:,4)-x(:,2))*Np)










