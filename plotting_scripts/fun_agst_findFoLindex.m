function output = fun_agst_findFoLindex(agentstat,index,FoL)

    if FoL == 0

        for i = 1 : length(agentstat)

            if fun_tr_cutter(agentstat(i).infectionTime) == index

                output = i;
                break;

            end

        end
        
    elseif FoL == 1
        
        for i = 1 : length(agentstat)

            if fun_tr_cutter(agentstat(i).infectionTime) == index && fun_tr_cutter(agentstat(i+1).infectionTime) ~= index

                output = i;
                break;

            end

        end
        
    end

end