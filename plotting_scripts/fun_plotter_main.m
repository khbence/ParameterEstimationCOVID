function output = fun_plotter_main(std_ip, agst_ip, tr_ip, scen_names, Title, std_flag, agst_flag, tr_flag)

        fun_plotter_std(std_ip,scen_names,Title,std_flag)
        fun_plotter_agst(agst_ip,scen_names,Title,agst_flag)
        output = fun_plotter_tr(tr_ip,agst_ip,scen_names,Title,tr_flag);

end