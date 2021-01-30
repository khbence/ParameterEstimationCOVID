function output = fun_agst_workplaceextract(agenstat,agents,location)

    k = 1;

    for i = 1 : length(agenstat)

        if  ~(strcmp(agenstat(i).loc_ID,'-1'))

            agentstat2(k).ID = agenstat(i).ID;
            agentstat2(k).InfectionLoc = agenstat(i).InfectionLoc;

            N = length(agents(agenstat(i).ID+1).locations);

            for j = 1 : N

                if agents(agenstat(i).ID+1).locations(j).typeID == 4 || agents(agenstat(i).ID+1).locations(j).typeID == 13

                    agentstat2(k).WorkPlace = agents(agenstat(i).ID+1).locations.locID;

                end

            end

            k = k + 1;

        end

    end
    
    N = length(agentstat2);
    k = 1;
    
    for i = 1 : N
        
        if ~(isempty(agentstat2(i).WorkPlace))
            
            agentstat3(k) = agentstat2(i);
            k = k + 1;
            
        end
        
    end
    
    for i = 1 : length(agentstat3)
        
        agentstat3(i).InfectionLoc = location{agentstat3(i).InfectionLoc+1,1}.ID;
        
    end
    
    for i = 1 : length(agentstat3)
        
        if strcmp(agentstat3(i).InfectionLoc,agentstat3(i).WorkPlace)
        
            agentstat3(i).workinfbool = 1;
            
        else
            
            agentstat3(i).workinfbool = 0;
            
        end
        
    end

    agentstat3 = rmfield(agentstat3,'InfectionLoc');
    agentstat3 = rmfield(agentstat3,'WorkPlace');
    
    agentstat3 = agentstat3';
    
    output = agentstat3;

end