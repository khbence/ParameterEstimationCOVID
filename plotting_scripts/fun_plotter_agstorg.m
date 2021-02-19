function fun_plotter_agstorg(agst_ip,scen_names,Title,agst_flag,agents,locations)

    if agst_flag == 1

        fun_plotter_agst(agst_ip,scen_names,Title,agst_flag,agents,locations,0,'general')
        fun_plotter_agst(agst_ip,scen_names,Title,agst_flag,agents,locations,1,'deceased portion')
        fun_plotter_agst(agst_ip,scen_names,Title,agst_flag,agents,locations,2,'quarantined portion')
        fun_plotter_agst(agst_ip,scen_names,Title,agst_flag,agents,locations,3,'pensioner portion')
    
    elseif agst_flag == 0
        fprintf("Agentstat input processing was not requested!\n")
    else
        fprintf("You used something other than 0 or 1 for a binary flag!\n")
    end

end