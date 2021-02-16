function output = fun_plotter_main(std_ip, agst_ip, tr_ip, scen_names, Title, Measures, StartDate, std_flag, agst_flag, tr_flag, rdata_flag)

        fun_plotter_std(std_ip,scen_names,Title,Measures,StartDate,std_flag,rdata_flag)
        fun_plotter_agstorg(agst_ip,scen_names,Title,agst_flag)
        output = fun_plotter_tr(tr_ip,agst_ip,scen_names,Title,Measures,StartDate,tr_flag);

end