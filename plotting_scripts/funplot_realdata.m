function funplot_realdata(hundata,numAgents,hunPopulation,w)

national = hundata*numAgents/hunPopulation;
data_len = numel(national);
plot(0:data_len-1,national,'Color',[255/255,69/255,0],'LineWidth',w,'DisplayName','National data');

end