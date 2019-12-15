import sys
import pefile

path = sys.argv[1]
pe = pefile.PE(path)
print("{0}".format(pe))