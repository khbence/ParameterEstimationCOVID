function [mean, standev] = fun_std_avdev(input,norm,varname)

    N = length(input);
    if ismember('re',varname)
        M = length(input(1).re);
    else
        M = length(input(1).s);
    end
    ip = input;
    
    av = zeros(M,1);
    stdev = zeros(M,1);

    for i = 1 : M
        
        sum = 0;
        stdev_init = zeros(N,1);
        
        for j = 1 : N
            
            sum2 = 0;
            O = length(varname);
            
            for k = 1 : O
                
                sum2 = sum2 + ip(j).(matlab.lang.makeValidName(varname{k}))(i);
                
            end
            
            varuse = sum2;
            
            sum = sum + varuse;
            stdev_init(j) = varuse;
            
        end
        
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
        
    end
    
    mean = av;
    standev = stdev;

end