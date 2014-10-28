from const import *
from utility import *
import shutil, os

svdU = map(float, ne(fileGet(svdUFile).split('\n')))
svdV = map(float, ne(fileGet(svdVFile).split('\n')))

docNames = fileGet(pyDocsFile).split()
stems = fileGet(pyStemsFile).split()

if os.path.isdir(indexPath):
    shutil.rmtree(indexPath)
os.mkdir(indexPath)

for i in range(len(stems)):
    stem = stems[i]
    weights = [getAngleBetween([svdU[i + k*len(stems)] for k in range(svdDims)],
                               [svdV[j + k*docsCount] for k in range(svdDims)]) for j in range(docsCount)]
    champList = sorted([(i, weights[i]) for i in range(docsCount)], key=lambda item: item[1])
    filePut(indexPath + stem.decode('utf-8'), str(champList))