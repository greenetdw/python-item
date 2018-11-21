# -*- coding: utf-8 -*-

# http://example.webscraping.com/places/ajax/search.json?&search_term=a&page_size=10&page=0

# http://example.webscraping.com/dynamic

from PySide.QtGui import *
from PySide.QtCore import *
from PySide.QtWebKit import *


app = QApplication([])
webview = QWebView()
loop = QEventLoop()

webview.loadFinished.connect(loop.quit)
webview.load(QUrl('http://example.webscraping.com/places/default/search'))
loop.exec_()
webview.show()
frame = webview.page().mainFrame()
frame.findFirstElement('#search_term').setAttribute('value', '.')
frame.findFirstElement('#page_size option:checked').setPlainText('1000')
frame.findFirstElement('#search').evaluateJavaScript('this.click()')

elements = None
while not elements:
    app.processEvents()
    elements = frame.findAllElements('#result a')
countries = [e.toPlainText().strip() for e in elements]
print countries



# app.exec_()



