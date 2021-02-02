function fun_plotter_agstorg(agst_ip,scen_names,Title,agst_flag)

    locations = jsondecode(fileread('locations0.json'));
    locations = locations.places;
    agents = jsondecode(fileread('agents0.json'));
    agents = agents.people;

    fun_plotter_agst(agst_ip,scen_names,Title,agst_flag,agents,locations,0,'general')
    fun_plotter_agst(agst_ip,scen_names,Title,agst_flag,agents,locations,1,'deceased portion')
    fun_plotter_agst(agst_ip,scen_names,Title,agst_flag,agents,locations,2,'quarantined portion')
    fun_plotter_agst(agst_ip,scen_names,Title,agst_flag,agents,locations,3,'pensioner portion')

end