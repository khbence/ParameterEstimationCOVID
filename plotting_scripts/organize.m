function [mean,standev] = organize(names)

    N = length(names(:,1));
    
    mean = [];
    standev = [];

    for i = 1 : N

        [av,st] = processing(names{i});
        mean = [mean av];
        standev = [standev st];

    end

end