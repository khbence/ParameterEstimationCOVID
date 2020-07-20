import os
import pandas
from io import StringIO
import numpy as np
from nelder_mead import NelderMead
from collections import OrderedDict
import matplotlib as mp
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation, ImageMagickWriter
import math

# mp.use( 'tkagg' )

class ParameterEstimation:
    refData = []
    n : int
    N : int
    length : int
    toPlot : bool

    #plot
    results = []

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
        return ' -P inputs/transition_final_dummy.json -A inputs/agentTypes.json -L inputs/locationTypes.json -p inputs/parameters_dummy.json -c inputs/config/out/configRandom.json'

    def __agentModel(self, params) -> list:
        # self.__modifyConfigRandom(params[0])
        sigmoidStr = self.__sigmoidParameters(params[0], 1.0, params[1], params[2])
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

def main():
    p = ParameterEstimation('inputs/deterministic_41_148.txt', 1000000, 1, 21, False)
    #p.plotSerie([0.13071, 0.36390, -0.44021, 23.29303], 0, 0.0, 0.2, 2)
    
    
    params = OrderedDict()
    # params["E"] = ["real", (1e-7, 0.1)]
    params["m"] = ["real", (0.001, 1.0)]
    # params["v"] = ["real", (0.001, 1.0)]
    params["H"] = ["real", (-1, 1)]
    params["s"] = ["real", (0, 100)]

    nm = NelderMead(p.objFunction, params)
    #nm.initialize([(1e-6, 0.125, 0.001, 0, 5), (1e-5, 0.125, 0.001, 0, 5), (1e-6, 0.13, 0.001, 0, 5), (1e-6, 0.125, 0.002, 0, 5), (1e-6, 0.125, 0.001, 0.1, 5), (1e-6, 0.125, 0.001, 0, 6)])
    nm.initialize([(0.12844, -0.430886, 23.30124)\
            , (0.10, -0.6, 10)\
            , (0.20, -0.3, 50)\
            , (0.30, 0.5, 23)])
    nm.minimize(n_iter=100)

if __name__ == "__main__":
    main()
