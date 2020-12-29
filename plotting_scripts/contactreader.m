function output = contactreader(input)

    data = readmatrix(input,delimitedTextImportOptions);

    places = double(split(string(data{2,1}),' '));
    boundariessus = double(split(string(data{3,1}),' '));
    boundariessus = boundariessus + 1;
    agentssus = double(split(string(data{4,1}),' '));
    boundariesinf = double(split(string(data{5,1}),' '));
    boundariesinf = boundariesinf + 1;
    agentsinf = double(split(string(data{6,1}),' '));
    
    out_var = cell(double(string(data{1,1})),3);
    
    for i = 1 : double(string(data{1,1}))
        
        val1 = boundariesinf(i);
        val2 = boundariesinf(i+1)-1;
        
        val3 = boundariessus(i);
        val4 = boundariessus(i+1)-1;
        
        out_var{i,1} = places(i);
        out_var{i,2} = agentssus(val3:val4);
        out_var{i,3} = agentsinf(val1:val2);
        
    end
    
    output = out_var;

end