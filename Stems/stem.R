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

ff = paste0(dataPath, 'documents-points.txt')

source(paste0(projectPath, "\\visual.R"))
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
print(dim(matrix))
print('svd start')
s = svd(matrix, dims, dims)
print('svd end')

getWords = function(vec) {
  res = c()
  for(i in 1:4) {
    res = append(res, which.max(vec))
    vec[which.max(vec)] = 0;
  }
  paste(unique(names[res]), collapse=",")
}

vmerge = function(a, b) {
  res = 1:length(a)
  for(i in 1:length(a))
    res[i] = min(a[i], b[i])
  res
}

HCtoJSON = function(hc) {
  labels<-hc$labels
  merge<-data.frame(hc$merge)
  for (i in (1:nrow(merge))) {
    s = paste0("list(name=getWords(vec", i, "), children=list")
    if      (merge[i,1]<0 & merge[i,2]<0) {
      node=paste0(s,"(list(name=labels[-merge[i,1]]),list(name=labels[-merge[i,2]])))")
      vec=paste0("vmerge(matrix[,-merge[i,1]],matrix[,-merge[i,2]])")
    }
    else if (merge[i,1]>0 & merge[i,2]<0) {
      node=paste0(s,"(node", merge[i,1], ", list(name=labels[-merge[i,2]])))")
      vec=paste0("vmerge(vec", merge[i,1], ",", "matrix[,-merge[i,2]])")
    }
    else if (merge[i,1]<0 & merge[i,2]>0) {
      node=paste0(s,"(list(name=labels[-merge[i,1]]), node", merge[i,2],"))")
      vec=paste0("vmerge(matrix[,-merge[i,1]],vec", merge[i,2], ")")
    }
    else if (merge[i,1]>0 & merge[i,2]>0) {
      node=paste0(s,"(node",merge[i,1] , ", node" , merge[i,2]," ))")
      vec=paste0("vmerge(vec", merge[i,1], ",vec", merge[i,2], ")")
    }
    #print(paste0("vec", i, "<-", vec))
    #print(paste0("node", i, "<-", node))
    eval(parse(text=  paste0("vec", i, "<-", vec)  ))
    eval(parse(text=  paste0("node", i, "<-", node)   ))
    
  }
  eval(parse(text=paste0("JSON<-toJSON(node",nrow(merge)-1, ")")))
  return(JSON)
}


docs = s$v

x = docs[,1]
y = docs[,2]

#plot(x, y, col=c, pch=20)

hc = hclust(dist(data.frame(docs)))
hc$labels = docnames
JSON = HCtoJSON(hc)
height = 22 * dim(docs)[1]
D3Dendo(JSON, width=2500, height=height, file_out=paste0(outPath, "dendrogram.html"))

# save svd
write(paste(c(s$v)), file=svdVFile)
write(paste(c(s$u)), file=svdUFile)