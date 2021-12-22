function funplot2(mean,std_dev,color,lw,name,style)

    % Valamiért csak az általam definiált vektorok transzponáltjait
    % szerette:

    mean = mean';
    std_dev = std_dev';
    
    % Kellett egy x-tengely:

    x = 0:numel(mean)-1;
    
    % Alsó és felső fedő görbék:
    
    curve1 = mean + std_dev;
    curve2 = mean - std_dev;
    
    % A két görbe x és y tengelyének egy-egy változóba foglalása:
    
    x2 = [x, fliplr(x)];
    inBetween = [curve1, fliplr(curve2)];
    
    % A két szélső görbe közötti space feltöltése (az 'edgecolor'-ral
    % tűntettem el a fedőgörbéket, a 'facealpha' halványít, a
    % 'Handevisibility' pedig azért kellett, hogy a plot szerint ez ne
    % legyen külön görbe, tehát ne rendeljen hozzá legendet):
    
    fill(x2,inBetween,color,'edgecolor','none','facealpha',0.1,'HandleVisibility','off');
    
    % Kitartás és a mean görbe plotolása ugyanazzal a színnel, definiálható
    % vastagsággal, a name pedig a legendhez kell (fontos, hogy ebből nem
    % jön automatikusan a legend, meg kell hívni ettől még, hogy legend(),
    % de nem kell megadni mert már tudni fogja:
    
    hold on;
    plot(x,mean,'Color',color,'LineWidth',lw,'DisplayName',name,'LineStyle',style);

end