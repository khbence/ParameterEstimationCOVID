function output = fun_agst_dqeextractor(AgentStat,agents,clog,LocMap)

    p = 1;
    
    for i = 1 : length(AgentStat)
        
        if clog == 1
            if strcmp(AgentStat(i).worstState_name,'D1')
                deceased(p) = AgentStat(i);
                p = p + 1;
            end
        elseif clog == 2
            if AgentStat(i).daysInQuarantine ~= 0
                quarantined(p) = AgentStat(i);
                p = p + 1;
            end
        elseif clog == 3
            booleanvar = 0;

            for j = 1 : length(agents(AgentStat(i).ID+1).locations)
                IDstring = agents(AgentStat(i).ID+1).locations(j).locID;
                IDint = agents(AgentStat(i).ID+1).locations(j).typeID;
                if IDint == 2
                    LocStruct = LocMap(IDstring);
                    if LocStruct.type == 22
                        booleanvar = 1;
                    end
                end
            end

            if booleanvar == 1
                elders(p) = AgentStat(i);
                p = p + 1;
            end
        elseif clog == 4
            if strcmp(AgentStat(i).worstState_name,'I5_h') ||...
               strcmp(AgentStat(i).worstState_name,'I6_h') ||...
               strcmp(AgentStat(i).worstState_name,'D1')
                hospitalized(p) = AgentStat(i);
                p = p + 1;
            end
        end
        
    end

    if clog == 1
        if exist('deceased','var') == 0
            deceased = 0;
        end
    elseif clog == 2
        if exist('quarantined','var') == 0
            quarantined = 0;
        end
    elseif clog == 3
        if exist('elders','var') == 0
            elders = 0;
        end
    elseif clog == 4
        if exist('hospitalized','var') == 0
            hospitalized = 0;
        end
    end
    
    if clog == 1
        output = deceased;
    elseif clog == 2
        output = quarantined;
    elseif clog == 3
        output = elders;
    elseif clog == 4
        output = hospitalized;
    end
end