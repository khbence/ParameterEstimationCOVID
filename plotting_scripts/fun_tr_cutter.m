function output = fun_tr_cutter(input)

    var = round(input);
    
    if var > input
        output = var-1;
    else
        output = var;
    end

end