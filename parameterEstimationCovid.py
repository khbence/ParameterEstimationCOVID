import os

def modifyConfigRandom(E):
    configRandomFile = open("inputs/config/in/configRandom.json.in", "rt")
    data = configRandomFile.read()
    data = data.replace('@S@', format(1.0 - E, '.20f'))
    data = data.replace('@E@', format(E, '.20f'))
    configRandomFile.close()
    configRandomFileOut = open("inputs/config/out/configRandom.json", "wt")
    configRandomFileOut.write(data)
    configRandomFileOut.close()

def sigmoidParameters(m, v, H, s) -> str:
    return '-m {} -v {} -H {} -s {}'.format(m, v, H, s)

def AgentModel(params) -> list:
    m = params[1]
    v = params[2]
    H = params[3]
    s = params[4]
    modifyConfigRandom(params[0])
    sigmoidStr = sigmoidParameters(params[1], params[2], params[3], params[4])
    


def main():
    AgentModel([0.00000004, 0.125, 0.001, 0, 5])

if __name__ == "__main__":
    main()