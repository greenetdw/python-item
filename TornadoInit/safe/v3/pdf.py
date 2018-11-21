# -*- coding: utf-8 -*-

import pyPdf
from pyPdf import PdfFileReader
from __builtin__ import str

def printMeta(fileName):
    pdfFile = PdfFileReader(file(fileName, 'rb'))
    docInfo = pdfFile.getDocumentInfo()
    print '[*] PDF MetaDta For : ' + str(fileName)
    for metaItem in docInfo:
        print '[+] ' + metaItem + ':' + docInfo[metaItem]


printMeta('E:\\test.pdf')