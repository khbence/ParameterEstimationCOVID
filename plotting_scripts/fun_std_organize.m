function [mean,standev] = fun_std_organize(names)

    N = length(names(1,:));
    
    mean = [];
    standev = [];

    for i = 1 : N

        [av,st] = fun_std_processing(names{i});
        mean = [mean av];
        standev = [standev st];

    end

end