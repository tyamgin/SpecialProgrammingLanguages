# -*- coding: utf-8 -*-

import re, math, sys
from porter import *
from const import *
from utility import *


def toRMatrix(a, stream, wrap):
    n, m = len(a), len(a[0])
    stream.write(' '.join(['"V' + str(j + 1) + '"' for j in range(m)]) + '\n')
    for i in range(n):
        stream.write(('"' + str(i + 1) + '" ' + ' '.join([wrap(a[i][j]) for j in range(m)]) + '\n'))


class FrequencyMatrix:
    def fillFromDocuments(self, docs):
        self.docs = docs    # документы
        self.docCount = {}  # количество документов по слову
        self.count = {}     # количество вхождений слова вообще

        for doc in docs:
            for stem in doc.stems:
                inc(self.docCount, stem)
                inc(self.count, stem, doc.stems[stem])

        self.stems = [stem for stem in self.docCount if self.count[stem] > 1]    # список популярных слов

        # удаление лишних слов
        stemsSet = {a for a in self.stems}
        for doc in docs:
            doc.stems = {stem: doc.stems[stem] for stem in doc.stems if stem in stemsSet}
            doc.stemsCount = sum(doc.stems.values())

        self.matrix = [[doc.count(stem) for doc in docs] for stem in self.stems]
        # https://ru.wikipedia.org/wiki/TF-IDF
        for i in range(len(self.stems)):
            idf = math.log(1.0 * len(self.docs) / self.docCount[self.stems[i]])
            #idf = 1
            for j in range(len(self.docs)):
                tf = 1.0 * self.matrix[i][j] / self.docs[j].stemsCount
                #tf = self.matrix[i][j]
                self.matrix[i][j] = tf * idf

    def write(self, file_path=None):
        stream = getOutput(file_path)
        for i in range(len(self.stems)):
            stream.write('%5s> %20s %s\n' % (i, self.stems[i], ' '.join(['%2.6f' % i for i in self.matrix[i]])))
        closeOutput(stream)

    def toRData(self, path=None):
        stream = getOutput(rMatrixFile)
        toRMatrix(self.matrix, stream, lambda x: '%f' % x)
        closeOutput(stream)

        stream = getOutput(rStemsFile)
        toRMatrix([self.stems], stream, lambda x: ('"%s"' % x).encode('utf-8'))
        closeOutput(stream)

        stream = getOutput(rDocsFile)
        toRMatrix([[doc.link for doc in self.docs]], stream, lambda x: '"%s"' % x)
        closeOutput(stream)

        filePut(pyStemsFile, ' '.join([stem.encode('utf-8') for stem in self.stems]))
        filePut(pyDocsFile, ' '.join([doc.link for doc in self.docs]))


class Document:
    def getWordsFromFile(self, filename):
        stream = open(filename, 'r')
        self.link = stream.readline().strip()
        splitter = re.compile(u'[^а-яА-Я]')
        content = '\n'.join(stream.readlines()).decode('utf-8').replace(u'ё', u'е').replace(u'Ё', u'Е')
        matches = splitter.split(content)
        result = [word.lower() for word in matches if len(word) > 2]
        stream.close()
        return result

    def read(self, file_path):
        words = self.getWordsFromFile(file_path)
        stems = map(getStem, words)

        self.stems = {}
        for stem in stems:
            inc(self.stems, stem)

    def count(self, stem):
        return self.stems[stem] if stem in self.stems else 0

    def write(self):
        for key in self.stems:
            print u'%20s %3s' % (key, self.stems[key])

print 'Documents parsing...'

docs = [Document() for i in range(docsCount)]
for i in range(docsTypes):
    for j in range(docsPer):
        docs[i * docsPer + j].read(docsPath + str(idxes[i]) + '_' + str(j) + '.txt')

print 'Matrix building...'

matrix = FrequencyMatrix()
matrix.fillFromDocuments(docs)
#matrix.write()

matrix.toRData(dataPath)

print 'end'