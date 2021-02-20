function output = fun_plotter_main(std_ip, agst_ip, tr_ip, scen_names, Title, Measures, StartDate, std_flag, agst_flag, tr_flag, rdata_flag)

    fun_plotter_std(std_ip,scen_names,Title,Measures,StartDate,std_flag,rdata_flag)
    
    if agst_flag == 1 || tr_flag == 1
        locations = jsondecode(fileread('locations0.json'));
        locations = locations.places;
        agents = jsondecode(fileread('agents0.json'));
        agents = agents.people;
    else
        agents = [];
        locations = [];
    end
    
    fun_plotter_agstorg(agst_ip,scen_names,Title,agst_flag,agents,locations)
    output = fun_plotter_tr(tr_ip,agst_ip,scen_names,Title,Measures,StartDate,tr_flag,agents,locations);

end