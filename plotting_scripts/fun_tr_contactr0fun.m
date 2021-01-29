function output = fun_tr_contactr0fun(inflist,agentstat,agents,locations)

    contactdata = fun_tr_contactorganizer(inflist);
    AgentStat = fun_agst_statreadprocfun(agentstat,agents,locations);
    
    var = zeros(length(AgentStat),1);
    for i = 1 : length(AgentStat)
        
        var(i) = AgentStat(i).ID;
        
    end
    
    var(:,2) = 0;
    
    for i = 1 : length(contactdata)
        
        seged = contactdata{i,2}{1,3};
        hossz = length(seged);
        
        for j = 1 : hossz
            
            var(find(var(:,1) == seged(j)),2) = var(find(var(:,1) == seged(j)),2) + (1/hossz);
            
        end
        
    end

    output.eloszlas = var;
    output.r0 = mean(var(:,2));
    
    summer = 0;
    iterer = 0;
    
    for i = 1 : length(var)
        if var(i,2) ~= 0
            summer = summer + var(i,2);
            iterer = iterer + 1;
        end
    end
    
    output.r0mod = summer/iterer;
    
end