function output = fun_agst_statreadprocfun(stat_name,agents,locations)

    fname = stat_name;
    AgentStat = jsondecode(fileread(fname));
    AgentStat = AgentStat.Statistics;

    for i = 1 : length(AgentStat)

        AgentStat(i).worstState_name = AgentStat(i).worstState.name;
        AgentStat(i).worstState_begin = AgentStat(i).worstState.begin;
        AgentStat(i).worstState_end = AgentStat(i).worstState.end;

        AgentStat(i).type = agents(AgentStat(i).ID+1).typeID;
        AgentStat(i).precond = agents(AgentStat(i).ID+1).preCond;
        AgentStat(i).age = agents(AgentStat(i).ID+1).age;
        AgentStat(i).sex = agents(AgentStat(i).ID+1).sex;
        
        if AgentStat(i).InfectionLoc ~= 0
            AgentStat(i).loc_ID = locations{AgentStat(i).InfectionLoc+1,1}.ID;
            AgentStat(i).loc_type = locations{AgentStat(i).InfectionLoc+1,1}.type;
            AgentStat(i).loc_area = locations{AgentStat(i).InfectionLoc+1,1}.area;
            AgentStat(i).loc_capacity = locations{AgentStat(i).InfectionLoc+1,1}.capacity;
            AgentStat(i).loc_infectious = locations{AgentStat(i).InfectionLoc+1,1}.infectious;
            AgentStat(i).loc_age = locations{AgentStat(i).InfectionLoc+1,1}.ageInter;
            AgentStat(i).loc_coord = locations{AgentStat(i).InfectionLoc+1,1}.coordinates;
        else
            AgentStat(i).loc_ID = '-1';
            AgentStat(i).loc_type = -1;
            AgentStat(i).loc_area = -1;
            AgentStat(i).loc_capacity = -1;
            AgentStat(i).loc_infectious = -1;
            AgentStat(i).loc_age = [-1;-1];
            AgentStat(i).loc_coord = [-1;-1];
        end

    end

    AgentStat = rmfield(AgentStat,'worstState');
    
    N = length(AgentStat);
    
    var_infectionTime = ((([AgentStat.infectionTime]')*10)/60)/24;
    var_diagnosisTime = ((([AgentStat.diagnosisTime]')*10)/60)/24;
    var_quarantinedTime = ((([AgentStat.quarantinedTime]')*10)/60)/24;
    var_quarantinedUntilTime = ((([AgentStat.quarantinedUntilTime]'+1)*10)/60)/24;
    var_hospitalizedTime = ((([AgentStat.hospitalizedTime]')*10)/60)/24;
    var_hospitalizedUntilTime = ((([AgentStat.hospitalizedUntilTime]')*10)/60)/24;
    var_worstState_begin = ((([AgentStat.worstState_begin]')*10)/60)/24;
    var_worstState_end = ((([AgentStat.worstState_end]')*10)/60)/24;
    
    for i = 1 : N
        AgentStat(i).infectionTime = var_infectionTime(i);
        AgentStat(i).diagnosisTime = var_diagnosisTime(i);
        AgentStat(i).quarantinedTime = var_quarantinedTime(i);
        AgentStat(i).quarantinedUntilTime = var_quarantinedUntilTime(i);
        AgentStat(i).hospitalizedTime = var_hospitalizedTime(i);
        AgentStat(i).hospitalizedUntilTime = var_hospitalizedUntilTime(i);
        AgentStat(i).worstState_begin = var_worstState_begin(i);
        AgentStat(i).worstState_end = var_worstState_end(i);
    end
    
    for i = 1 : N
        if AgentStat(i).worstState_end ~= abs(AgentStat(i).worstState_end)
            AgentStat(i).worstState_end = -1;
        end
    end
    
    for i = 1 : length(AgentStat)
        segvar = length(agents(AgentStat(i).ID+1).locations);
        for j = 1 : segvar
            if agents(AgentStat(i).ID+1).locations(j).typeID == 4 || agents(AgentStat(i).ID+1).locations(j).typeID == 13
                AgentStat(i).WorkPlace = agents(AgentStat(i).ID+1).locations(j).locID;
            end
        end
    end
    
    for i = 1 : length(AgentStat)
        if strcmp(AgentStat(i).loc_ID,AgentStat(i).WorkPlace)
            AgentStat(i).workinfbool = 1;
        else
            AgentStat(i).workinfbool = 0;
        end
    end
    
    AgentStat = struct2table(AgentStat);
    AgentStat = sortrows(AgentStat, 'infectionTime');
    AgentStat = table2struct(AgentStat);
    
    output = AgentStat;

end