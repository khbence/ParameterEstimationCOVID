function output = traceinit(AgentStat)

    sum = 0;

    for i = 1 : length(AgentStat)

        if AgentStat(i).infectionTime == 0

            sum = sum + 1;

        end

    end


    tracer = zeros(sum,2);
    k = 1;

    for i = 1 : length(AgentStat)

        if AgentStat(i).infectionTime == 0

            tracer(k,1) = AgentStat(i).ID;
            k = k+1;

        end

    end
    
    output = tracer;

end