projectPath = 'D:\\Projects\\Anafiev\\Stems\\'
dataPath = paste0(projectPath, 'data\\')
outPath = paste0(projectPath, 'out\\')
docsPath = paste0(dataPath, 'texts\\')
indexPath = paste0(dataPath, 'index\\')

pyStemsFile = paste0(dataPath, 'pyStems.txt')
pyDocsFile = paste0(dataPath, 'pyDocs.txt')
rStemsFile = paste0(dataPath, 'rStems.txt')
rDocsFile = paste0(dataPath, 'rDocs.txt')
rMatrixFile = paste0(dataPath, 'rMatrix.txt')
svdUFile = paste0(dataPath, 'pySvdU.txt')
svdVFile = paste0(dataPath, 'pySvdV.txt')

source(paste0(projpath, "\\visual.R"))
# http://www.coppelia.io/converting-an-r-hclust-object-into-a-d3-js-dendrogram/

getDist = function(a, b) {
  acos( sum(a*b) / ( sqrt(sum(a * a)) * sqrt(sum(b * b)) ) )
}

getDistMatrix = function(x) {
  res = dist(x)
  sz = 1
  for(i in 1:dim(x)[1]) {
    j = i + 1
    while(j <= dim(x)[1]) {
      res[sz] = getDist(x[i,], x[j,])
      sz = sz + 1
      j = j + 1
    }
  }
  res
}

names = as.matrix(read.table(rStemsFile))
docnames = as.matrix(read.table(rDocsFile))
matrix = read.table(rMatrixFile)
dims = 10
s = svd(matrix, dims, dims)

types = 15

c = c()
for (i in 1:types)
  c = append(c, matrix(i+1, dim(matrix)[2]/types)[,1])

docs = s$v

x = docs[,1]
y = docs[,2]

plot(x, y, col=c, pch=20)

hc = hclust(dist(data.frame(docs)))
hc$labels = docnames
JSON = HCtoJSON(hc)
height = 20 * dim(docs)[1]
D3Dendo(JSON, width=1500, height=height, file_out=paste0(outPath, "dendrogram.html"))

# save svd
write(paste(c(s$v)), file=svdVFile)
write(paste(c(s$u)), file=svdUFile)