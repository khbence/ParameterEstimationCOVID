import os
import pandas
from io import StringIO
import numpy as np
import matplotlib as mp
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation, ImageMagickWriter
import math
import sys

# mp.use( 'tkagg' )

class ParameterEstimation:
    refData = []
    length : int
    toPlot : bool
    n = 222503

    #plot
    results = []

    def __init__(self, refFile, length, toPlot):
        with open(refFile) as f:
            for line in f: # read lines
                self.refData.append([float(i) for i in line.split()][0])
        self.length = length
        self.toPlot = toPlot
        self.peakValue = np.max(self.refData)
        self.peakPos = np.argmax(self.refData)
        print("Reference peak position and value: {} - {}".format(self.peakPos, self.peakValue))

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
        return ' -r -P ../COVIDAgentModel/inputFiles/progressions/transition_config.json -A ../COVIDAgentModel/inputFiles/agentTypes.json -a ../COVIDAgentModel/inputFiles/KamiData/agents0.json -l ../COVIDAgentModel/inputFiles/KamiData/locations0.json ../ -L ../COVIDAgentModel/inputFiles/locationTypes.json -p ../COVIDAgentModel/inputFiles/parameters.json -c inputs/config/out/configRandom.json'

    def __agentModel(self, params) -> list:
        self.__modifyConfigRandom(0.0004)
        sigmoidStr = self.__sigmoidParameters(params[0], 1.0, params[1], params[2])
        files = self.__filePaths()
        #print('./covid -w {}{}{}'.format(self.length, sigmoidStr, files))
        agentOutput = os.popen('./covid -w {}{}{}'.format(self.length, sigmoidStr, files)).read()
        #print(agentOutput)
        try:
            outDataFrame = pandas.read_csv(StringIO(agentOutput), sep='\t', index_col=False)
        except pandas.errors.EmptyDataError:
            print(agentOutput)
            sys.exit()

        ret =  outDataFrame[['I1', 'I2', 'I3', 'I4', 'I5_hospital', 'I6_hospital']].sum(axis = 1)
        ret = ret.to_numpy()
#        print("calculated: " + str(ret))
        return ret / self.n
    
    def plotThem(self, params):
        for i in range(0, 15):
            simResult = self.__agentModel(params)
            plt.plot(simResult)
            plt.plot(self.refData)
            plt.gca().set_xlabel("Days")
            plt.gca().set_ylabel("Infected percentage")
            print("lengths: {} - {}".format(len(simResult), len(self.refData)))
            plt.savefig("figures/tmp{}.png".format(i))
            plt.close()


def main():
    p = ParameterEstimation('inputs/deterministic_41_188_new.txt', 21, False)
    p.plotThem([0.32559, -0.42991, 22.25235])

if __name__ == "__main__":
    main()
