function plotter_agst(jsonnames,scenarionames,Title,flag)

    if flag == 1
        
        data = agstorganize(jsonnames);
        
        figure('Name','Plots1_agst','NumberTitle','off')
        
        subplot(2,3,1)

        bar_age = categorical({'0-9','10-19','20-29','30-39','40-49','50-59','60-69','70-79','80-89','90-99'});
        bar_age = reordercats(bar_age,{'0-9','10-19','20-29','30-39','40-49','50-59','60-69','70-79','80-89','90-99'});
        h = bar(bar_age,data.av.age);
        set(h, {'DisplayName'}, scenarionames);
        legend('Location','best');
        xlabel('Age intervals [years]');
        ylabel('Number of agents');
        title('Age group distr. of the inf. population');
        
        subplot(2,3,2)
        
        bar_precond = categorical({'Healthy','Diabetes','CV','Chronickidney','COP'});
        bar_precond = reordercats(bar_precond,{'Healthy','Diabetes','CV','Chronickidney','COP'});
        h = bar(bar_precond,data.av.precond);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of agents')
        title('Precond. distr. of the inf. population')
        
        subplot(2,3,3)
        
        bar_sex = categorical({'Female','Male'});
        bar_sex = reordercats(bar_sex,{'Female','Male'});
        h = bar(bar_sex,data.av.sex);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of agents')
        title('Sex distr. of the inf. population')
        
        subplot(2,3,4)
        
        bar_worststate = categorical({'E','I_1','I_2','I_3','I_4','I_{5,h}','I_{6,h}','D'});
        bar_worststate = reordercats(bar_worststate,{'E','I_1','I_2','I_3','I_4','I_{5,h}','I_{6,h}','D'});
        var = data.av.worststate;
        var(:,10) = var(:,1);
        var(:,1:2) = [];
        h = bar(bar_worststate,var);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of agents')
        title('State distr.')
        
        subplot(2,3,5)
        
        bar_infections = categorical({'Infected','Not infected'});
        bar_infections = reordercats(bar_infections,{'Infected','Not infected'});
        h = bar(bar_infections,data.av.infections);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of agents')
        title('Infected - Not infected agents')
        
        subplot(2,3,6)
        
        bar_diagnosises = categorical({'Diagnosed','Not diagnosed'});
        bar_diagnosises = reordercats(bar_diagnosises,{'Diagnosed','Not diagnosed'});
        h = bar(bar_diagnosises,data.av.diagnoses);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of agents')
        title('Diagnosed - Not diagnosed agents')
        
        sgtitle(append(Title,' (Statistics no.1)'))
        
        figure('Name','Plots2_agst','NumberTitle','off')
        
        subplot(2,1,1)
        
        bar_agenttype = categorical({'Infant','Kindergarten','Elementary school','High school','University','Full-time','Afternoon shift','Home office','Tourist'});
        bar_agenttype = reordercats(bar_agenttype,{'Infant','Kindergarten','Elementary school','High school','University','Full-time','Afternoon shift','Home office','Tourist'});
        h = bar(bar_agenttype,data.av.agenttype);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of agents')
        title('Agent type distribution of the infected population')
        
        subplot(2,1,2)
        
        bar_locationtype = categorical({'Public spaces','Residence','Public education','Full-time work place','Small social site','Large social site','Short visiting site','Long visiting site','Weekend social sites','Recreational sites','Closed facility','Hospital','Non-standard workplace','Health center','Nursery home','Classroom','University'});
        bar_locationtype = reordercats(bar_locationtype,{'Public spaces','Residence','Public education','Full-time work place','Small social site','Large social site','Short visiting site','Long visiting site','Weekend social sites','Recreational sites','Closed facility','Hospital','Non-standard workplace','Health center','Nursery home','Classroom','University'});
        h = bar(bar_locationtype,data.av.locationtype);
        set(h, {'DisplayName'}, scenarionames)
        legend('Location','best')
        ylabel('Number of agents')
        title('Location type distribution of the infected population')
        
        sgtitle(append(Title,' (Statistics no.2)'))
        
    elseif flag == 0
        fprintf("Agentstat input processing was not requested!\n")
    else
        fprintf("You used something other than 0 or 1 for a binary flag!\n")
    end
    
end