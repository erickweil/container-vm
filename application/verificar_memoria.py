#!/usr/bin/python3
# https://github.com/nestybox/sysbox/issues/714
# Isto é necessário pois quando usa o SysBox não dá para ver
# o uso de memória no docker stats
import subprocess
import re
from functools import reduce

def ssplit(txt):
        return re.split(r'\s\s+',txt)

def buildObj(headers,splited):
        ret = {}
        if len(splited) < len(headers):
                return False
        i = 0
        for header in headers:
                ret[header] = splited[i]
                i += 1
        return ret

def execShell(cmd):
        result = subprocess.run(cmd, stdout=subprocess.PIPE)
        return result.stdout.decode('utf-8')

# https://stackoverflow.com/questions/1094841/get-human-readable-version-of-file-size
def sizeof_fmt(num, suffix="B"):
    for unit in ("", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi"):
        if abs(num) < 1024.0:
            return f"{num:3.1f}{unit}{suffix}"
        num /= 1024.0
    return f"{num:.1f}Yi{suffix}"


result = execShell(['docker','ps','--no-trunc'])
#print(result)

linhas = result.split('\n')

headers = ssplit(linhas[0])
outputTable = [["Nome","Memória"]]
for linha in linhas[1:]:
        try:
                info = buildObj(headers,ssplit(linha))
                if not info:
                        continue
                scopePath = "/sys/fs/cgroup/system.slice/docker-{id}.scope/memory.current".format(id = info["CONTAINER ID"])

                # Como ler os valores de uso de memória cgroupv2
                # https://github.com/kubernetes/kubernetes/issues/118916
                memBytes = int(execShell(['cat',scopePath]).strip())

                #print("{name}\t{mem}".format(name=info["NAMES"],mem=sizeof_fmt(memBytes)))
                outputTable.append([info["NAMES"],sizeof_fmt(memBytes)])
        except e:
                outputTable.append(["ERRO",e])

nomeLength = max([len(l[0]) for l in outputTable])

for row in outputTable:
        print(row[0]," "*(nomeLength-len(row[0])),row[1])

#CONTAINERS=$(docker ps -q --no-trunc)
#for c in $CONTAINERS; do
#       cat /sys/fs/cgroup/system.slice/docker-$c.scope/memory.current
#done
