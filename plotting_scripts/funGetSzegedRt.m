function output = funGetSzegedRt()

    url = 'https://docs.google.com/spreadsheets/d/1djH-yUHLPwuEExCjiXS__6-8W2Yp_msFvShpL4bBcuM/export?format=xlsx&gid=1460833902';
    filename = 'szeged_data/coronamonitornewcases.xlsx';
    websave(filename,url);

    data = readtable('szeged_data/coronamonitornewcases.xlsx');
    data.H_tnaposMozg__tlag = [];
    data(1:203,:) = [];
    data.D_tum = [];
    data = table2array(data);
    data = data*(179530/9770000);
    
    data_fin = zeros(length(data),1);
    for i = 11 : length(data)-9
        data_fin(i) = sum((data(i:i+9))/(sum(data(i-10:i-1))));
    end
    data_fin = funNaNorInferaser(data_fin);
    
    output = data_fin;

end