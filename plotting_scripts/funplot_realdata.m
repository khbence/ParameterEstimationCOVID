function funplot_realdata(hundata,numAgents,hunPopulation,w)

national = hundata*numAgents/hunPopulation;
data_len = numel(national);
plot(0:data_len-1,national,'Color',[0.4470 0.7410 0],'LineWidth',w,'DisplayName','National data');

end