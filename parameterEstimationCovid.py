import os
import pandas
from io import StringIO
import numpy as np
import nelder_mead.nelder_mead as nmp
from collections import OrderedDict
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
        return ' -r -P ../COVIDAgentModel/inputFiles/progressions/transition_config.json -A ../COVIDAgentModel/inputFiles/agentTypes.json -a ../COVIDAgentModel/inputFiles/KamiData/agents0.json -l ../COVIDAgentModel/inputFiles/KamiData/locations0.json ../ -L ../COVIDAgentModel/inputFiles/locationTypes.json -p inputs/parameters.json -c inputs/configRandom.json'

    def __agentModel(self, params) -> list:
        #self.__modifyConfigRandom(0.0004)
        sigmoidStr = self.__sigmoidParameters(params[0], 1.0, params[1], params[2])
        files = self.__filePaths()
        print('./covid -w {}{}{}'.format(self.length, sigmoidStr, files))
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
    
    def objFunctionBrute(self, params):
        agent = self.__agentModel(params)
        if(self.toPlot):
            plt.plot(self.refData, label = 'ref')
            plt.plot(agent, label = 'agent')
            plt.show()
        ret = np.linalg.norm(agent - np.array(self.refData))
        return ret
    
    def objFunctionPeak(self, params):
        agent = self.__agentModel(params)
        #print(list(agent))
        agentPeakPos = np.argmax(agent)
        agentPeakValue = np.max(agent)
        print("Simulation peak position and value: {} - {}".format(agentPeakPos, agentPeakValue))
        peakError = abs(agentPeakPos - self.peakPos) / (len(self.refData)/2)
        valueError = abs(self.peakValue - agentPeakValue) / self.peakValue
        print()
        a = 1
        b = 2
        return ((peakError * b) + (valueError * a)) / (a + b)

    def update(self, idx):
        self.line.set_ydate(self.results[idx])
        return self.line, self.ax

    def plotSerie(self, params, paramIdx, a, b, N):
        fig, self.ax = plt.subplots()
        fig.set_tight_layout(True)
        #x = np.arange(41, 183, 1)
        step = (a - b)/(N-1)
        self.ax.plot(self.refData, label = 'ref')
        self.line, = self.ax.plot(self.__agentModel(params), label = 'agent')
        for i in range(0, N):
            print(i)
            params[paramIdx] = a + (i * step)
            self.results.append(self.__agentModel(params))

        anim = FuncAnimation(fig, self.update, frames=np.arange(0, N))
        writer = ImageMagickWriter()
        anim.save('out.gif', dpi = 80, writer = writer)
    
    def gridSearchMS(self, N):
        mValues = np.linspace(0.001, 1, N)
        sValues = np.linspace(1, 100, N)
        fig, ax = plt.subplots(1,1)
        print(mValues)
        print(sValues)
        result = np.zeros(shape=(N, N))
        i = 0
        j = 0
        for m in mValues:
            for s in sValues:
                print("dims {} {}, values {} {}".format(i, j, m, s))
                result[i][j] = self.objFunctionBrute([m, s])
                j += 1
            i += 1
            j = 0
        ax = plt.imshow(result)
        plt.savefig('foo.png')

def main():
    p = ParameterEstimation('inputs/deterministic_41_188_new.txt', 21, False)
    #p.plotSerie([0.13071, 0.36390, -0.44021, 23.29303], 0, 0.0, 0.2, 2)
    #p.gridSearchMS(3)

    
    params = OrderedDict()
    # -0.45186
    # params["E"] = ["real", (1e-7, 0.1)]
    #-m 0.13116 -v 0.36112 -H -0.43942 -s 22.83681 
    params["m"] = ["real", (0.001, 1.0)]
    # params["v"] = ["real", (0.001, 1.0)]
    params["H"] = ["real", (-1, 1)]
    params["s"] = ["real", (0, 100)]
    nm = nmp.NelderMead(p.objFunctionPeak, params)
    nm.initialize([(0.16033, -0.45161, 14.41757), (0.47218, -0.43716, 32.19956), (0.46362, -0.43369, 31.28905), (0.45218, -0.44716, 33.19956)])
    nm.minimize(n_iter=100)

if __name__ == "__main__":
    main()
