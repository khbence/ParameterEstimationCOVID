function output = plotter_tr(tr_ip,agst_ip,scenarionames,Title,flag)

    if flag == 1
        
        locations = jsondecode(fileread('locations0.json'));
        locations = locations.places;
        agents = jsondecode(fileread('agents0.json'));
        agents = agents.people;
        
        output = tracepostprocess(tr_ip,agst_ip,agents,locations);
        
    elseif flag == 0
        fprintf("Contact tracing input processing was not requested!\n")
    else
        fprintf("You used something other than 0 or 1 for a binary flag!\n")
    end
    
end