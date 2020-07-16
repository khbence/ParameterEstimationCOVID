import os
import pandas
from io import StringIO

class ParameterEstimation:
    def modifyConfigRandom(self, E):
        configRandomFile = open("inputs/config/in/configRandom.json.in", "rt")
        data = configRandomFile.read()
        data = data.replace('@S@', format(1.0 - E, '.20f'))
        data = data.replace('@E@', format(E, '.20f'))
        configRandomFile.close()
        configRandomFileOut = open("inputs/config/out/configRandom.json", "wt")
        configRandomFileOut.write(data)
        configRandomFileOut.close()

    def sigmoidParameters(self, m, v, H, s) -> str:
        return ' -m {} -v {} -H {} -s {}'.format(m, v, H, s)

    def filePaths(self) -> str:
        return ' -P inputs/transition_final.json -A inputs/agentTypes.json -L inputs/locationTypes.json -p inputs/parameters.json -c inputs/config/out/configRandom.json'

    def AgentModel(self,params, n, N, length) -> list:
        modifyConfigRandom(params[0])
        sigmoidStr = sigmoidParameters(params[1], params[2], params[3], params[4])
        files = filePaths()
        agentOutput = os.popen('./covid -n {} -N {} -w {}{}{}'.format(n, N, length, sigmoidStr, files)).read()
        outDataFrame = pandas.read_csv(StringIO(agentOutput), sep='\t', index_col=False)
        print(outDataFrame)
        ret =  outDataFrame[['I1', 'I2', 'I3', 'I4', 'I5', 'I6']].sum(axis = 1)
        return ret.tolist()

def main():
    ParameterEstimation p()
    p.AgentModel([0.04, 0.125, 0.001, 0, 5], 1000, 1, 1)

if __name__ == "__main__":
    main()