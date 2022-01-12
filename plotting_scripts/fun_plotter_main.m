function output = fun_plotter_main(std_ip,agst_ip,tr_ip,scen_names,Title,Measures,StartDate,...
                                   std_flag,agst_flag,tr_flag,rdata_flag,Path,colors,intervals,begintint,ctw_flag)

    colors = colors/255;

    if ctw_flag == 1
        locations = jsondecode(fileread('locations0.json'));
        locations = locations.places;
        agents = jsondecode(fileread('agents0.json'));
        agents = agents.people;
        fprintf("AgentStat processing for standard statistics initiated!\n")
        fun_agst_preread(agst_ip,agents,locations);
        fprintf("AgentStat processing for standard statistics finished!\n")
    else
        agents = [];
        locations = [];
    end
    
    if std_flag == 1
        %fun_plotter_std(std_ip,scen_names,Title,Measures,StartDate,rdata_flag,Path,...
        %                'No. of Agents',colors,begintint,agst_ip,ctw_flag)
        fun_plotter_std(std_ip,scen_names,Title,Measures,StartDate,rdata_flag,Path,...
                        'Ratio to Total Population (%)',colors,begintint,agst_ip,ctw_flag) %Emberek száma
        fprintf("Standard input successfully processed!\n")
    elseif std_flag == 0
        fprintf("Standard input processing was not requested!\n")
    else
        fprintf("You used something other than 0 or 1 for a binary flag!\n")
    end
    
    if ctw_flag ~= 1 && agst_flag == 1
        locations = jsondecode(fileread('locations0.json'));
        locations = locations.places;
        agents = jsondecode(fileread('agents0.json'));
        agents = agents.people;
        LocMap = funloc2map(locations);
    elseif ctw_flag == 1 && agst_flag == 1
        LocMap = funloc2map(locations);
    else
        agents = [];
        locations = [];
        LocMap = [];
    end
    
    fun_plotter_agstit(agst_ip,scen_names,Title,agst_flag,agents,Path,LocMap,intervals,locations)
    
    if ctw_flag ~= 1 && agst_flag ~= 1 && tr_flag == 1
        locations = jsondecode(fileread('locations0.json'));
        locations = locations.places;
        agents = jsondecode(fileread('agents0.json'));
        agents = agents.people;
    elseif ctw_flag == 1 && agst_flag ~= 1 && tr_flag == 1
        LocMap = [];
    elseif ctw_flag ~= 1 && agst_flag == 1 && tr_flag == 1
        LocMap = [];
    elseif ctw_flag == 1 && agst_flag == 1 && tr_flag == 1
        LocMap = [];
    else
        agents = [];
        locations = [];
    end
    
    output = fun_plotter_tr(tr_ip,agst_ip,scen_names,Title,Measures,StartDate,tr_flag,agents,locations,Path,colors);

end
