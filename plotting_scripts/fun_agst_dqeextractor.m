function [deceased,quarantined,elders] = fun_agst_dqeextractor(AgentStat,agents)

    p = 1;
    q = 1;
    r = 1;
    
    for i = 1 : length(AgentStat)
        
        if strcmp(AgentStat(i).worstState_name,'D1')
            deceased(p) = AgentStat(i);
            p = p + 1;
        end
        
        if AgentStat(i).daysInQuarantine ~= 0
            quarantined(q) = AgentStat(i);
            q = q + 1;
        end
        
        booleanvar = 0;
        
        for j = 1 : length(agents(AgentStat(i).ID+1).locations)
            if agents(AgentStat(i).ID+1).locations(j).typeID == 22
                booleanvar = 1;
            end
        end
        
        if booleanvar == 1
            elders(r) = AgentStat(i);
            r = r + 1;
        end
        
    end

    if exist('deceased','var') == 0
        deceased = 0;
    end
    if exist('quarantined','var') == 0
        quarantined = 0;
    end
    if exist('elders','var') == 0
        elders = 0;
    end
    
end