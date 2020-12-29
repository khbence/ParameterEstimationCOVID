function plotterpp(txtnames,scenarionames,Title,standard_flag,advanced_flag)

    if standard_flag == 1 && advanced_flag == 0
        plotter(txtnames,scenarionames,Title)
    elseif standard_flag == 0 && advanced_flag == 1
        fprintf("A funkcio jelenleg nem elerheto!\n")
    elseif standard_flag == 1 && advanced_flag == 1
        fprintf("A funkcio jelenleg nem elerheto!\n")
    else
        fprintf("Nem lehet mind a ketto flag nulla!\n")
    end

end