# Plotting scripts

To run the scripts, and evaluate the data coming from the simulator, one should use the *fun_plotter_main(std_ip, agst_ip, tr_ip, scen_names, title, measures, std_flag, agst_flag, tr_flag, rdata_flag)* function. An example for its usage can be seen in the *main.m* file. Now let's list its inputs:

  - *std_ip* : a cell array of strings, which contains the file names and paths of the standard outputs
  - *agst_ip* : a cell array of strings, which contains the file names and paths of the agentstat outputs
  - *tr_ip* : a cell array of strings, which contains the file names and paths of the contact tracing outputs
  - *scen_names* : a cell array of strings, which contains the names of the scenarios, that will be displayed on the plots
  - *title* : this is a string, which can provide additional information on the plots in form of a title
  - *measures* : a cell array, 1st column is a string array (name of the applied measure), second is double array (day when the measure was applied), it is for plotting vertical dashed lines to represent applied measures in the simulation
  - *std_flag* : a binary on/off switch, it determines if the standard output should be processed
  - *agts_flag* : a binary on/off switch, it determines if the agentstat output should be processed
  - *tr_flag* : a binary on/off switch, it determines if the contact tracing output should be processed
  - *rdata_flag*: a binary on/off switch, it determines if we want to plot the national data of not.

**Note:** each flag is expected to be a 0 or 1 value, otherwise the user will get a "You used something other than 0 or 1 for a binary flag!" message. In case of a 0 value a "*type of input* was not requested!" message will be displayed.

