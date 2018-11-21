# -*- coding: UTF-8 -*-

def getcitys():
    city_list = []
    cityFile = open('../../../city.txt', 'r')
    for city in cityFile.readlines():
        city = city.strip('\n')
        city_list.append(city)
    return city_list


def get_template_tables():
    table_list = []
    tFile = open('../../../table.txt', 'r')
    for t in tFile.readlines():
        t = t.strip('\n')
        table_list.append(t)
    return table_list
        
