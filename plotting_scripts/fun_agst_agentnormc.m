function output = fun_agst_agentnormc(agents,scennum)

    N = length(agents);
    
    output.ages = zeros(8,1);
    output.precond = zeros(5,1);
    output.typeID = zeros(9,1);
    
    for i = 1 : N
        
        it = agents(i).age;
        
        if sum(it == 0:5)
            output.ages(1) = output.ages(1) + 1;
        elseif sum(it == 6:14)
            output.ages(2) = output.ages(2) + 1;
        elseif sum(it == 15:18)
            output.ages(3) = output.ages(3) + 1;
        elseif sum(it == 19:30)
            output.ages(4) = output.ages(4) + 1;
        elseif sum(it == 31:62)
            output.ages(5) = output.ages(5) + 1;
        elseif sum(it == 63:70)
            output.ages(6) = output.ages(6) + 1;
        elseif sum(it == 71:80)
            output.ages(7) = output.ages(7) + 1;
        elseif sum(it == 81:150)
            output.ages(8) = output.ages(8) + 1;
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
    
    for i = 2 : scennum
        
        output.ages(:,i) = output.ages(:,1);
        output.precond(:,i) = output.precond(:,1);
        output.typeID(:,i) = output.typeID(:,1);
        
    end

    output.ages = output.ages';
    output.precond = output.precond';
    output.typeID = output.typeID';
    
end