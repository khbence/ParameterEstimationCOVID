function output = fun_plotter_main(std_ip,agst_ip,tr_ip,scen_names,Title,Measures,StartDate,std_flag,agst_flag,tr_flag,rdata_flag,Path,colors,intervals)

    colors = colors/255;

    if std_flag == 1
        fun_plotter_std(std_ip,scen_names,Title,Measures,StartDate,rdata_flag,Path,'No. of Agents',colors)
        fun_plotter_std(std_ip,scen_names,Title,Measures,StartDate,rdata_flag,Path,'Ratio to Total Population (%)',colors)
        fprintf("Standard input successfully processed!\n")
    elseif std_flag == 0
        fprintf("Standard input processing was not requested!\n")
    else
        fprintf("You used something other than 0 or 1 for a binary flag!\n")
    end
    
    if agst_flag == 1
        locations = jsondecode(fileread('locations0.json'));
        locations = locations.places;
        agents = jsondecode(fileread('agents0.json'));
        agents = agents.people;
        LocMap = funloc2map(locations);
    else
        agents = [];
        locations = [];
        LocMap = [];
    end
    
    fun_plotter_agstit(agst_ip,scen_names,Title,agst_flag,agents,Path,LocMap,intervals)
    
    if agst_flag ~= 1 && tr_flag == 1
        locations = jsondecode(fileread('locations0.json'));
        locations = locations.places;
        agents = jsondecode(fileread('agents0.json'));
        agents = agents.people;
    else
        agents = [];
        locations = [];
    end
    
    output = fun_plotter_tr(tr_ip,agst_ip,scen_names,Title,Measures,StartDate,tr_flag,agents,locations,Path,colors);

end