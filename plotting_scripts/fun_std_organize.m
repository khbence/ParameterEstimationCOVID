function [mean,standev] = fun_std_organize(names)

    N = length(names(:,1));
    
    mean = [];
    standev = [];
    meancell = cell(N,1);
    standevcell = cell(N,1);
    for i = 1:N
        [av,st] = fun_std_processing(names{i});
        meancell{i} = av;
        standevcell{i} = st;
    end

    for i = 1 : N
        mean = [mean meancell{i}];
        standev = [standev standevcell{i}];

    end

end