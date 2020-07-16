import os
import pandas
from io import StringIO
import numpy as np
from nelder_mead import NelderMead
from collections import OrderedDict
import matplotlib.pyplot as plt

class ParameterEstimation:
    refData = []
    n : int
    N : int
    length : int
    toPlot : bool

    def __init__(self, refFile, n, N, length, toPlot):
        with open(refFile) as f:
            for line in f: # read lines
                self.refData.append([float(i) for i in line.split()][0])
        self.n = n
        self.N = N
        self.length = length
        self.toPlot = toPlot

    def __modifyConfigRandom(self, E):
        configRandomFile = open("inputs/config/in/configRandom.json.in", "rt")
        data = configRandomFile.read()
        data = data.replace('@S@', format(1.0 - E, '.20f'))
        data = data.replace('@E@', format(E, '.20f'))
        configRandomFile.close()
        configRandomFileOut = open("inputs/config/out/configRandom.json", "wt")
        configRandomFileOut.write(data)
        configRandomFileOut.close()

    def __sigmoidParameters(self, m, v, H, s) -> str:
        return ' -m {} -v {} -H {} -s {}'.format(m, v, H, s)

    def __filePaths(self) -> str:
        return ' -P inputs/transition_final.json -A inputs/agentTypes.json -L inputs/locationTypes.json -p inputs/parameters.json -c inputs/config/out/configRandom.json'

    def __agentModel(self, params) -> list:
        # self.__modifyConfigRandom(params[0])
        sigmoidStr = self.__sigmoidParameters(params[0], params[1], 0, 5)
        files = self.__filePaths()
        agentOutput = os.popen('./covid -n {} -N {} -w {}{}{}'.format(self.n, self.N, self.length, sigmoidStr, files)).read()
        outDataFrame = pandas.read_csv(StringIO(agentOutput), sep='\t', index_col=False)
        ret =  outDataFrame[['I1', 'I2', 'I3', 'I4', 'I5', 'I6']].sum(axis = 1)
#        print("calculated: " + str(ret))
        return ret.to_numpy() / self.n
    
    def objFunction(self, params):
        agent = self.__agentModel(params)
        if(self.toPlot):
            plt.plot(self.refData, label = 'ref')
            plt.plot(agent, label = 'agent')
            plt.show()
        ret = np.linalg.norm(agent - np.array(self.refData))
        return ret

def main():
    p = ParameterEstimation('inputs/deterministic_41_148.txt', 1000000, 1, 21, False)
    params = OrderedDict()
    # params["E"] = ["real", (1e-7, 0.1)]
    params["m"] = ["real", (0.001, 0.3)]
    params["v"] = ["real", (0.0001, 0.003)]
    # params["H"] = ["real", (-1, 1)]
    # params["s"] = ["real", (1, 10)]

    nm = NelderMead(p.objFunction, params)
    #nm.initialize([(1e-6, 0.125, 0.001, 0, 5), (1e-5, 0.125, 0.001, 0, 5), (1e-6, 0.13, 0.001, 0, 5), (1e-6, 0.125, 0.002, 0, 5), (1e-6, 0.125, 0.001, 0.1, 5), (1e-6, 0.125, 0.001, 0, 6)])
    nm.initialize([(0.14457, 0.00228), (0.13, 0.001), (0.125, 0.0005)])
    nm.minimize()

if __name__ == "__main__":
    main()
