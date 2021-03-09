function fun_plotter_agstit(agst_ip,scen_names,Title,agst_flag,agents,Path,LocMap,intervals)

    if agst_flag == 1
        
        fun_agst_preread(agst_ip);
        
        boundaries_2_run = size(intervals);
        
        for i = 1 : boundaries_2_run(1)
            fun_plotter_agstorg(agst_ip,scen_names,Title,agents,Path,LocMap,i,intervals(i,:))
        end
    
    elseif agst_flag == 0
        fprintf("Agentstat input processing was not requested!\n")
    else
        fprintf("You used something other than 0 or 1 for a binary flag!\n")
    end

end