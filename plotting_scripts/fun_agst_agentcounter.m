function count = fun_agst_agentcounter(input,agents,clog,LocMap)

    AgentStat = fun_agst_statreadprocfun(input);

    if clog == 0
        count = fun_agst_agentcountercount(AgentStat);
    end
    
    if clog ~= 0
        output = fun_agst_dqeextractor(AgentStat,agents,clog,LocMap);
        if ~(isequaln(output,0))
            count = fun_agst_agentcountercount(output);
        elseif isequaln(output,0)
            count = 0;
        end
    end
    
end