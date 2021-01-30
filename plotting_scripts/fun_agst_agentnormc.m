function output = fun_agst_agentnormc(agents)

    N = length(agents);
    
    output.ages = zeros(10,1);
    output.precond = zeros(5,1);
    output.typeID = zeros(9,1);
    
    for i = 1 : N
        
        it = agents(i).age;
        
        if sum(it == [0 1 2 3 4 5 6 7 8 9])
            output.ages(1) = output.ages(1) + 1;
        elseif sum(it == 10+[0 1 2 3 4 5 6 7 8 9])
            output.ages(2) = output.ages(2) + 1;
        elseif sum(it == 20+[0 1 2 3 4 5 6 7 8 9])
            output.ages(3) = output.ages(3) + 1;
        elseif sum(it == 30+[0 1 2 3 4 5 6 7 8 9])
            output.ages(4) = output.ages(4) + 1;
        elseif sum(it == 40+[0 1 2 3 4 5 6 7 8 9])
            output.ages(5) = output.ages(5) + 1;
        elseif sum(it == 50+[0 1 2 3 4 5 6 7 8 9])
            output.ages(6) = output.ages(6) + 1;
        elseif sum(it == 60+[0 1 2 3 4 5 6 7 8 9])
            output.ages(7) = output.ages(7) + 1;
        elseif sum(it == 70+[0 1 2 3 4 5 6 7 8 9])
            output.ages(8) = output.ages(8) + 1;
        elseif sum(it == 80+[0 1 2 3 4 5 6 7 8 9])
            output.ages(9) = output.ages(9) + 1;
        elseif sum(it == 90+[0 1 2 3 4 5 6 7 8 9])
            output.ages(10) = output.ages(10) + 1;
        end
        
        it = agents(i).preCond;
        
        if it == '0'
            output.precond(1) = output.precond(1) + 1;
        elseif it == '1'
            output.precond(2) = output.precond(2) + 1;
        elseif it == '2'
            output.precond(3) = output.precond(3) + 1;
        elseif it == '3'
            output.precond(4) = output.precond(4) + 1;
        elseif it == '4'
            output.precond(5) = output.precond(5) + 1;
        end
        
        output.typeID(agents(i).typeID) = output.typeID(agents(i).typeID) + 1;
        
    end

end