# Plotting scripts

To run the scripts, and evaluate the data coming from the simulator, one should use the *plotterpp(std_ip, agst_ip, tr_ip, scen_names, title, std_flag, agst_flag, tr_flag)* function. An example for its usage can be seen in the *main.m* file. Now let's list its inputs:

  - *std_ip* : a cell array of strings, which contains the file names and paths of the standard outputs
  - *agst_ip* : a cell array of strings, which contains the file names and paths of the agentstat outputs
  - *tr_ip* : a cell array of strings, which contains the file names and paths of the contact tracing outputs
  - *scen_names* : a cell array of strings, which contains the names of the scenarios, that will be displayed on the plots
  - *title* : this is a string, which can provide additional information on the plots in form of a title
  - *std_flag* : a binary on/off switch, it determines if the standard output should be processed
  - *agts_flag* : a binary on/off switch, it determines if the agentstat output should be processed
  - *tr_flag* : a binary on/off switch, it determines if the contact tracing output should be processed

**Note:** each flag is expected to be a 0 or 1 value, otherwise the user will get a "You used something other than 0 or 1 for a binary flag!" message. In case of a 0 value a "<type of input> was not requested!" message will be displayed.

