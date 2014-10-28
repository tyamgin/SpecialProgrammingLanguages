projectPath = 'D:\\Projects\\Anafiev\\Stems\\'
dataPath = projectPath + 'data\\'
outPath = projectPath + 'out\\'
docsPath = dataPath + 'texts\\'
indexPath = dataPath + 'index\\'

pyStemsFile = dataPath + 'pyStems.txt'
pyDocsFile = dataPath + 'pyDocs.txt'
rStemsFile = dataPath + 'rStems.txt'
rDocsFile = dataPath + 'rDocs.txt'
rMatrixFile = dataPath + 'rMatrix.txt'
distFile = dataPath + 'pyDist.txt'

svdUFile = dataPath + 'pySvdU.txt'
svdVFile = dataPath + 'pySvdV.txt'

wiki = 'https://ru.wikipedia.org'

svdDims = 10

idxes = [i for i in range(15)]
docsTypes = len(idxes)
docsPer = 60
docsCount = docsTypes * docsPer