function output = plotterpp(std_ip, agst_ip, tr_ip, scen_names, Title, std_flag, agst_flag, tr_flag)

        plotter_std(std_ip,scen_names,Title,std_flag)
        plotter_agst(agst_ip,scen_names,Title,agst_flag)
        output = plotter_tr(tr_ip,agst_ip,scen_names,Title,tr_flag);

end