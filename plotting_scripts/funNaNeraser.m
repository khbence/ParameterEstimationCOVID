function output = funNaNeraser(input)

    N = length(input);
    
    for i = 1 : N
        
        if isnan(input(i))
            
            input(i) = 0;
            
        end
        
    end
    
    output = input;

end