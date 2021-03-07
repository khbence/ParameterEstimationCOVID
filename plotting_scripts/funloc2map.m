function output = funloc2map(locations)

    for i = 1 : length(locations)
        locations{i,2} = locations{i,1}.ID;
        locations{i,1} = rmfield(locations{i,1},'ID');
    end

    locations(end-1:end,:) = [];

    keySet = locations(:,2);
    valueSet = locations(:,1);

    output = containers.Map(keySet,valueSet);

end