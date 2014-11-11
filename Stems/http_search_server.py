# -*- coding: utf-8 -*-

import time, BaseHTTPServer, os

from porter import *
from const import *
from utility import *
import urlparse, traceback, subprocess

HOST_NAME = 'localhost'
PORT_NUMBER = 7777


def getChampList(stem):
    stream = open(indexPath + stem)
    result = eval(stream.readline())
    stream.close()
    return result


def getTopPage(champDict, top=10):
    champList = sorted([(i, champDict[i]) for i in champDict], key=lambda x: x[1])
    top = min(top, len(champList))
    docNames = fileGet(pyDocsFile).split()

    o = '<ol>'
    for i in range(top):
        idx = champList[i][0]
        w = 1 - champList[i][1] / math.pi
        o += '<li><a href="%s">%s</a> <sup>%.2f%%</sup></li>' % (docNames[idx], docNames[idx], 100*w)
    o += '</ol>'
    return o


def processSearchQuery(q):
    try:
        stems = [getStem(word.decode('utf-8')) for word in q.split()]
        for stem in stems:
            print stem
        stems = [stem for stem in stems if os.path.isfile(indexPath + stem)]
        if len(stems) < 1:
            return 'bad request'
        champDict = {}
        cl = [getChampList(stem) for stem in stems]
        w = {}
        for i in range(len(stems)):
            for item in cl[i]:
                if item[2]:
                    inc(w, item[0])
        for i in range(len(stems)):
            for item in cl[i]:
                inc(champDict, item[0], item[1] / (1 + at(w, item[0])) * len(stems))
        return getTopPage(champDict)
    except Exception as e:
        traceback.print_exc()
        return 'bad request (crash)'


class MyHandler(BaseHTTPServer.BaseHTTPRequestHandler):
    def do_HEAD(s):
        s.send_response(200)
        s.send_header("Content-type", "text/html")
        s.end_headers()
    def do_GET(s):
        """Respond to a GET request."""
        s.send_response(200)
        s.send_header("Content-type", "text/html")
        s.end_headers()

        timer = time.time()

        o = urlparse.urlparse(s.path)
        get = urlparse.parse_qs(o.query)
        q = get['q'][0] if 'q' in get else ''

        s.wfile.write("""
                  <!DOCTYPE html>
                    <head>
                        <meta charset='utf-8'>
                        <title>Search results</title>
                    </head>
                    <body>
                        <!-- time: """ + str(time.time() - timer) + """ -->
                        <form action='http://""" + HOST_NAME + """:""" + str(PORT_NUMBER) + """'>
                            <input name="q" type="text" placeholder="your search request" value='""" + q + """'>
                            <input type="submit" value="Search">
                        </form>

                        """ + (processSearchQuery(q) if q else '') + """
                    </body>
                  </html>""")

if __name__ == '__main__':
    server_class = BaseHTTPServer.HTTPServer
    httpd = server_class((HOST_NAME, PORT_NUMBER), MyHandler)
    print time.asctime(), "Server Starts - %s:%s" % (HOST_NAME, PORT_NUMBER)
    subprocess.call('start http://%s:%d' % (HOST_NAME, PORT_NUMBER), shell=True)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
    print time.asctime(), "Server Stops - %s:%s" % (HOST_NAME, PORT_NUMBER)