# -*- coding: UTF-8 -*-
import csv

class CsvUtils:
    
    def __init__(self):
        self.writer = csv.writer(open('一分钱补偿用户账户余额20181106.csv', 'w'))
        self.fields = ('username', 'realname', 'earning_balance')
        self.writer.writerow(self.fields)
    
