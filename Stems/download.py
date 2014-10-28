# -*- coding: utf-8 -*-

from urllib2 import *
from const import *
import time, urllib


def getLinks(theme, limit):
    href = wiki + '/w/index.php?title=Служебная:Поиск&limit='+str(limit)+'&offset=0&profile=default&search='+theme
    try:
        page = urlopen(href).read()
        r = re.compile('mw-search-result-heading[\'][>][<]a href=["](.*?)["]')
        return map(lambda a: urllib.unquote(a).decode('utf8'), r.findall(page))
    except:
        print theme + ' failed'
        return []


def download(themes, limit, startIndex):
    for i in range(len(themes)):
        links = getLinks(themes[i], limit)
        for j in range(len(links)):
            link = wiki + links[j].encode('utf-8')

            try:
                a = urlopen(link).read()
            except:
                print link + ' failed'
                a = '<div id="mw-content-text" lang="ru" dir="ltr" class="mw-content-ltr"> none <div class="printfooter">'

            a = a.split('<div id="mw-content-text" lang="ru" dir="ltr" class="mw-content-ltr">')
            a = a[1].split('<div class="printfooter">')[0]

            stream = open(docsPath + str(i + startIndex) + '_' + str(j) + '.txt', 'w')
            stream.write(link + '\n' + a)
            stream.close()

            print '%d %d' % (i + startIndex, j)
"""
themes = ['Тригонометрия', 'Грипп', 'Автомобиль', 'Хлеб', 'Москва',
          'Техника', 'Таврия', 'Биржа', 'Депутат', 'Газ',
          'Яндекс', 'Водка', 'Русский', 'Видео', 'Собака'
]
"""
themes = ['Финал', 'Кризис', 'Лодка', 'Екатеринбург', 'Взятка'
          'США', 'СССР', 'Улица', 'Вероятность', 'Защита',
          'Иванов', 'Дорога', 'Реклама', 'Дождь', 'Уран'
]
download(themes, 100, 15)