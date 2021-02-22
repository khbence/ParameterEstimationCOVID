function fun_plotter_agst(jsonnames,scenarionames,Title,agents,locations,clog,spectitle,Path)
        
    scennum = length(scenarionames);

    [data,agents,itbool] = fun_agst_organize(jsonnames,agents,locations,clog);
    
    if ~exist(Path, 'dir')
        mkdir(Path)
    end

    if sum(itbool) ~= 0

        normnum = fun_agst_agentnormc(agents,scennum);

        hossz = scennum;
        indeces2bedeleted = [];

        for i = 1 : hossz
            if itbool(i) == 0
                indeces2bedeleted = [indeces2bedeleted i];
            end
        end

        scenarionames(indeces2bedeleted) = [];

        FIGH = figure('Name','Plots1_agst','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(2,2,1)

        bar_age = categorical({'0-9','10-19','20-29','30-39','40-49','50-59','60-69','70-79','80-89','90-99'});
        bar_age = reordercats(bar_age,{'0-9','10-19','20-29','30-39','40-49','50-59','60-69','70-79','80-89','90-99'});
        h = bar(bar_age,data.av.age);
        set(h, {'DisplayName'}, scenarionames);
        legend('Location','best');
        xlabel('Age intervals [years]');
        ylabel('Number of agents');
        title('Age group distribution');

        subplot(2,2,2)

        bar_precond = categorical({'Healthy','Diabetes','Cardiovascular','Kidney','Obst. pulmonary'});
        bar_precond = reordercats(bar_precond,{'Healthy','Diabetes','Cardiovascular','Kidney','Obst. pulmonary'});
        h = bar(bar_precond,data.av.precond);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        xlabel('COVID-related chronic illnesses')
        ylabel('Number of agents')
        title('Precondition distribution')

        subplot(2,2,3)

        bar_age = categorical({'0-9','10-19','20-29','30-39','40-49','50-59','60-69','70-79','80-89','90-99'});
        bar_age = reordercats(bar_age,{'0-9','10-19','20-29','30-39','40-49','50-59','60-69','70-79','80-89','90-99'});
        h = bar(bar_age,data.av.age./normnum.ages);
        set(h, {'DisplayName'}, scenarionames);
        legend('Location','best');
        xlabel('Age intervals [years]');
        ylabel('Number of agents (normed)');
        title('Ratio of infected agents in age groups');

        subplot(2,2,4)

        bar_precond = categorical({'Healthy','Diabetes','Cardiovascular','Kidney','Obst. pulmonary'});
        bar_precond = reordercats(bar_precond,{'Healthy','Diabetes','Cardiovascular','Kidney','Obst. pulmonary'});
        h = bar(bar_precond,data.av.precond./normnum.precond);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        xlabel('COVID-related chronic illnesses')
        ylabel('Number of agents (normed)')
        title('Ratio of infected agents in precondition groups')

        sgtitle(append(Title,' (Statistics-1 of the infected population) ',spectitle))
        
        F = getframe(FIGH);
        mkdir(append(Path,'/ags'))
        imwrite(F.cdata,append(Path,'/ags/ags_',spectitle,'-1.jpg'),'jpg')
        savefig(append(Path,'/ags/ags_',spectitle,'-1.fig'))

        FIGH = figure('Name','Plots2_agst','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(2,2,1)

        bar_sex = categorical({'Female','Male'});
        bar_sex = reordercats(bar_sex,{'Female','Male'});
        h = bar(bar_sex,data.av.sex);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of agents')
        title('Sex distribution')

        subplot(2,2,2)

        bar_worststate = categorical({'Exposed','Presymptomatic','Asymptomatic','Light symptomatic','Mild symptomatic','Hospitalized','Intensive care','Deceased'});
        bar_worststate = reordercats(bar_worststate,{'Exposed','Presymptomatic','Asymptomatic','Light symptomatic','Mild symptomatic','Hospitalized','Intensive care','Deceased'});
        var = data.av.worststate;
        var(:,10) = var(:,1);
        var(:,1:2) = [];
        h = bar(bar_worststate,var);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of agents')
        set(gca,'YScale','log')
        title('Worst state distribution')

        subplot(2,2,3)

        bar_infections = categorical({'Infected','Not infected'});
        bar_infections = reordercats(bar_infections,{'Infected','Not infected'});
        h = bar(bar_infections,data.av.infections);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of agents')
        set(gca,'YScale','log')
        title('Infected - Not infected agents')

        subplot(2,2,4)

        bar_diagnosises = categorical({'Diagnosed','Not diagnosed'});
        bar_diagnosises = reordercats(bar_diagnosises,{'Diagnosed','Not diagnosed'});
        h = bar(bar_diagnosises,data.av.diagnoses);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of agents')
        title('Diagnosed - Not diagnosed agents')

        sgtitle(append(Title,' (Statistics-2 of the infected population) ',spectitle))
        
        F = getframe(FIGH);
        imwrite(F.cdata,append(Path,'/ags/ags_',spectitle,'-2.jpg'),'jpg')
        savefig(append(Path,'/ags/ags_',spectitle,'-2.fig'))

        FIGH = figure('Name','Plots3_agst','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(2,2,1)

        bar_agenttype = categorical({'Infant','Kindergarten student','Elementary school student','High school student','University student','Full-time (standard, fixed)','Afternoon shift worker','Stay-at-home schedule','Tourist'});
        bar_agenttype = reordercats(bar_agenttype,{'Infant','Kindergarten student','Elementary school student','High school student','University student','Full-time (standard, fixed)','Afternoon shift worker','Stay-at-home schedule','Tourist'});
        h = bar(bar_agenttype,data.av.agenttype);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of agents')
        set(gca,'YScale','log')
        title('Agent type distribution')

        subplot(2,2,2)

        bar_agenttype = categorical({'Infant','Kindergarten student','Elementary school student','High school student','University student','Full-time (standard, fixed)','Afternoon shift worker','Stay-at-home schedule','Tourist'});
        bar_agenttype = reordercats(bar_agenttype,{'Infant','Kindergarten student','Elementary school student','High school student','University student','Full-time (standard, fixed)','Afternoon shift worker','Stay-at-home schedule','Tourist'});
        h = bar(bar_agenttype,data.av.agenttype./normnum.typeID);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of agents (normed)')
        set(gca,'YScale','log')
        title('Agent type distribution (normed with category size)')

        subplot(2,2,[3 4])

        bar_locationtype = categorical({'Public spaces','Residence','Public education','Std., full-time wp.','Small social site','Large social site','Short visiting site','Long visiting site','Weekend social sites','Recreational sites','Closed facility','Hospital','Non-std. schedule wp.','Health center','Commuters','Nursery home','Classroom','University'});
        bar_locationtype = reordercats(bar_locationtype,{'Public spaces','Residence','Public education','Std., full-time wp.','Small social site','Large social site','Short visiting site','Long visiting site','Weekend social sites','Recreational sites','Closed facility','Hospital','Non-std. schedule wp.','Health center','Commuters','Nursery home','Classroom','University'});
        h = bar(bar_locationtype,data.av.locationtype);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of infections')
        set(gca,'YScale','log')
        title('Infection locations')

        sgtitle(append(Title,' (Statistics-3 of the infected population) ',spectitle))
        
        F = getframe(FIGH);
        imwrite(F.cdata,append(Path,'/ags/ags_',spectitle,'-3.jpg'),'jpg')
        savefig(append(Path,'/ags/ags_',spectitle,'-3.fig'))

        fprintf(append("Agent statistics input successfully processed! (",spectitle,")\n"))
    else
        fprintf(append('Agent statistics cannot be processed for the ',spectitle,', because there were no agents to start with!\n'));
    end
    
end