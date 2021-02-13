function output = fun_tr_addinfevents(index,contactdata,tracer)

    for i = 1 : length(index)

        seged = size(contactdata{index(i),2});
        seged = seged(1);

        for j = 1 : seged

            segvar = length(contactdata{index(i),2}{j,3});
            infnum = length(contactdata{index(i),2}{j,2});

            for k = 1 : segvar

                indexvar = find(tracer(:,1) == contactdata{index(i),2}{j,3}(k));
                tracer(indexvar,2) = tracer(indexvar,2) + (infnum/segvar);
            end

        end

    end
    
    output = tracer;

end