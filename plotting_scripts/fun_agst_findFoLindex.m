function output = fun_agst_findFoLindex(agentstat,index,FoL)

    if FoL == 0

        while exist(output,'var')
            for i = 1 : length(agentstat)

                if funcutter(agentstat(i).infectionTime) == index

                    output = i;
                    break;

                end

            end
            
            index = index + 1;
        end
        
    elseif FoL == 1
        
        while exist(output,'var')
            for i = 1 : length(agentstat)

                if funcutter(agentstat(i).infectionTime) == index && fun_tr_cutter(agentstat(i+1).infectionTime) ~= index

                    output = i;
                    break;

                end

            end
            
            index = index - 1;
        end
        
    end

end