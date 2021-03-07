function fun_plotter_agst(jsonnames,scenarionames,Title,agents,locations,clog,spectitle,Path,LocMap)
        
    scennum = length(scenarionames);

    [data,agents,itbool] = fun_agst_organize(jsonnames,agents,locations,clog,LocMap);
    
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
        
        angle = 45;

        FIGH = figure('Name','Plots1_agst','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(2,2,1)

        avmat = data.av.age;
        sdmat = data.std.age;
        h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels({'0-9','10-19','20-29','30-39','40-49','50-59','60-69','70-79','80-89','90-99'});
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best');
        xtickangle(angle)
        xlabel('Age intervals [years]');
        ylabel('Number of agents');
        title('Age group distribution');

        subplot(2,2,2)
        
        avmat = data.av.precond;
        sdmat = data.std.precond;
        h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels({'Healthy','Diabetes','Cardiovascular','Kidney','Obst. pulmonary'});
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best')
        xtickangle(angle)
        xlabel('COVID-related chronic illnesses')
        ylabel('Number of agents')
        title('Precondition distribution')

        subplot(2,2,3)
        
        avmat = data.av.age./normnum.ages;
        sdmat = data.std.age./normnum.ages;
        h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels({'0-9','10-19','20-29','30-39','40-49','50-59','60-69','70-79','80-89','90-99'});
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best');
        xtickangle(angle)
        xlabel('Age intervals [years]');
        ylabel('Number of agents (normed)');
        title('Ratio of infected agents in age groups');

        subplot(2,2,4)

        avmat = data.av.precond./normnum.precond;
        sdmat = data.std.precond./normnum.precond;
        h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels({'Healthy','Diabetes','Cardiovascular','Kidney','Obst. pulmonary'});
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best')
        xtickangle(angle)
        xlabel('COVID-related chronic illnesses')
        ylabel('Number of agents (normed)')
        title('Ratio of infected agents in precondition groups')

        sgtitle(append(Title,' (Statistics-1 of the infected population) ',spectitle))
        
        F = getframe(FIGH);
        mkdir(append(Path,'/ags'))
        imwrite(F.cdata,append(Path,'/ags/ags_',spectitle,'-1.jpg'),'jpg')
        savefig(append(Path,'/ags/z_ags_',spectitle,'-1.fig'))

        FIGH = figure('Name','Plots2_agst','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(2,2,1)

        avmat = data.av.sex;
        sdmat = data.std.sex;
        h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels({'Female','Male'});
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best')
        xtickangle(angle)
        ylabel('Number of agents')
        title('Sex distribution')

        subplot(2,2,2)

        var = data.av.worststate;
        var(:,10) = var(:,1);
        var(:,1:2) = [];
        avmat = var;
        var = data.std.worststate;
        var(:,10) = var(:,1);
        var(:,1:2) = [];
        sdmat = var;
        h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels({'Exposed','Presymptomatic','Asymptomatic','Light symptomatic','Mild symptomatic','Hospitalized','Intensive care','Deceased'});
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best')
        xtickangle(angle)
        ylabel('Number of agents')
        set(gca,'YScale','log')
        title('Worst state distribution')

        subplot(2,2,3)

        avmat = data.av.infections;
        sdmat = data.std.infections;
        h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels({'Infected','Not infected'});
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best')
        xtickangle(angle)
        ylabel('Number of agents')
        set(gca,'YScale','log')
        title('Infected - Not infected agents')

        subplot(2,2,4)

        avmat = data.av.diagnoses;
        sdmat = data.std.diagnoses;
        h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels({'Diagnosed','Not diagnosed'});
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best')
        xtickangle(angle)
        ylabel('Number of agents')
        title('Diagnosed - Not diagnosed agents')

        sgtitle(append(Title,' (Statistics-2 of the infected population) ',spectitle))
        
        F = getframe(FIGH);
        imwrite(F.cdata,append(Path,'/ags/ags_',spectitle,'-2.jpg'),'jpg')
        savefig(append(Path,'/ags/z_ags_',spectitle,'-2.fig'))

        FIGH = figure('Name','Plots3_agst','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(2,2,1)

        avmat = data.av.agenttype;
        sdmat = data.std.agenttype;
        h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels({'Infant','Kindergarten student','Elementary school student','High school student','University student','Full-time (standard, fixed)','Afternoon shift worker','Stay-at-home schedule','Tourist'});
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best')
        xtickangle(angle)
        ylabel('Number of agents')
        set(gca,'YScale','log')
        title('Agent type distribution')

        subplot(2,2,2)

        avmat = data.av.agenttype./normnum.typeID;
        sdmat = data.std.agenttype./normnum.typeID;
        h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels({'Infant','Kindergarten student','Elementary school student','High school student','University student','Full-time (standard, fixed)','Afternoon shift worker','Stay-at-home schedule','Tourist'});
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best')
        xtickangle(angle)
        ylabel('Number of agents (normed)')
        set(gca,'YScale','log')
        title('Ratio of infected agents in agent types')

        subplot(2,2,[3 4])

        avmat = data.av.locationtype;
        sdmat = data.std.locationtype;
        h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels({'Public spaces','Residence','Public edu.','Std. workplace','Small soc. event','Large soc. event','Short stay POI','Long stay POI','Weekend activity','Recreational sites','Closed facility','Hospital','Non-std. schedule wp.','Health center','Commuters','Nursing home','Classroom','University'});
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best')
        xtickangle(angle-15)
        ylabel('Number of infections')
        set(gca,'YScale','log')
        title('Infection locations')

        sgtitle(append(Title,' (Statistics-3 of the infected population) ',spectitle))
        
        F = getframe(FIGH);
        imwrite(F.cdata,append(Path,'/ags/ags_',spectitle,'-3.jpg'),'jpg')
        savefig(append(Path,'/ags/z_ags_',spectitle,'-3.fig'))

        fprintf(append("Agent statistics input successfully processed! (",spectitle,")\n"))
    else
        fprintf(append('Agent statistics cannot be processed for the ',spectitle,', because there were no agents to start with!\n'));
    end
    
end