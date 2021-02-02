function count = fun_agst_agentcounter(input,agents,locations,clog)

    AgentStat = fun_agst_statreadprocfun(input,agents,locations);
    
    [deceased,quarantined,elders] = fun_agst_dqeextractor(AgentStat,agents);

    if clog == 0
        count = fun_agst_agentcountercount(AgentStat);
    end
    
    if clog == 1 && deceased ~= 0
        count = fun_agst_agentcountercount(deceased);
    elseif clog == 1 && deceased == 0
        count = 0;
    end
    
    if clog == 2 && quarantined ~= 0
        count = fun_agst_agentcountercount(quarantined);
    elseif clog == 2 && quarantined == 0
        count = 0;
    end
    
    if clog == 3 && elders ~= 0
        count = fun_agst_agentcountercount(elders);
    elseif clog == 3 && elders == 0
        count = 0;
    end
    
end