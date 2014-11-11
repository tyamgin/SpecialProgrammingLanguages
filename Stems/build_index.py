# -*- coding: utf-8 -*-

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

docsCount = len(enumerateFiles(docsPath))

stream = getInput(pyMatrixFile)
matrix = [map(float, stream.readline().split()) for i in range(len(stems))]
closeInput(stream)

for i in range(len(stems)):
    stem = stems[i]
    weights = [getAngleBetween([svdU[i + k*len(stems)] for k in range(svdDims)],
                               [svdV[j + k*docsCount] for k in range(svdDims)]) for j in range(docsCount)]
    champList = sorted([(j, weights[j], matrix[i][j]) for j in range(docsCount)], key=lambda item: item[1])
    filePut(indexPath + stem.decode('utf-8'), str(champList))