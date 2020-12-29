function output = addnewinf(index,contactdata,tracer)

    for i = 1 : length(index)

        seged = size(contactdata{index(i),2});
        seged = seged(1);

        for j = 1 : seged

            segvar = length(contactdata{index(i),2}{j,2});

            for k = 1 : segvar

                tracer(end+1,:) = [contactdata{index(i),2}{j,2}(k) 0];

            end

        end

    end

    output = tracer;

end