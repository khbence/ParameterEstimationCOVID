# Plotting scripts

To run the scripts, and evaluate the data coming from the simulator, one should use the *fun_plotter_main(std_ip, agst_ip, tr_ip, scen_names, title, measures, startdate, std_flag, agst_flag, tr_flag, rdata_flag, path, colors)* function. An example for its usage can be seen in the *main.m* file. Now let's list its inputs:

  - *std_ip* : a cell array of strings, which contains the path(s) and file name(s) of the standard outputs at given scenario(s)
  - *agst_ip* : a cell array of strings, which contains the path(s) and file name(s) of the agentstat outputs at given scenario(s)
  - *tr_ip* : a cell array of strings, which contains the path(s) and file name(s) of the contact tracing outputs at given scenario(s)
  - *scen_names* : a cell array of strings, which contains the names of the scenarios, that will be displayed on the plots
  - *title* : this is a string, which can provide additional information on the plots as a title
  - *measures* : a cell array, 1st column is a string array (name of the applied measure), second is double array (day when the measure was applied), it is for plotting vertical dashed lines to represent applied measures in the simulation
  - *startdate* : a string, given in mm/dd/yy format, it is for initializing the first point of the time-axis
  - *std_flag* : a binary on/off switch, it determines if the standard output should be processed
  - *agts_flag* : a binary on/off switch, it determines if the agentstat output should be processed
  - *tr_flag* : a binary on/off switch, it determines if the contact tracing output should be processed
  - *rdata_flag*: a binary on/off switch, it determines if we want to plot the national and the deterministic data or not
  - *path*: give the name and path of the folder, where the figures should be saved
  - *colors*: color of the time series plot for each scenario
  - *intervals*: a N×2 array, where N is the number of intervals in time, that should be investigated by the AgentStat analysis, in each row a pair of values is given, where the first value is the beginning of a given interval, and the second value is the end of that interval
  - *begintint*: no. of elements to be discarded from the beginning of the time series
 

**Note:** each flag is expected to be a 0 or 1 value, otherwise the user will get a "You used something other than 0 or 1 for a binary flag!" message. In case of a 0 value a "*type of input* was not requested!" message will be displayed. Also the number of scenarios are limited to 8, that can be plotted each time.

There are 3 kind of inputs for the plotting scripts, the Standard input, the Agent-dependent input and the Contact tracing input. There are conventions how to name these files while running simulations. These conventions can be seen below:

  - Standard input: <some arbitrary user defined name>_<simulation count>.txt
  - Agent dependent input: <some arbitrary user defined name>_<simulation count>.json
  - Contact tracing input: this is a folder for each round, the folder name must be <some arbitrary user defined name>_<simulation count>

