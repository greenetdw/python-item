# -*- coding: UTF-8 -*-

city_codes = [
    "110000", 
    "150300", 
    "310000", 
    "320100", 
    "330100", 
    "410100", 
    "410200", 
    "410500", 
    "410600", 
    "410700", 
    "410800", 
    "410900", 
    "411400", 
    "419000", 
    "420100", 
    "440100", 
    "440300", 
    "441300", 
    "610100"
]

for city_code in city_codes:
    sql = "update obtain_earning_info o, common_task_"+city_code+" c , project_info p set o.earning_package_id = p.earning_package_id \
    where o.task_id is not null and o.task_id = c.id and c.project_id = p.id ;"
    print sql










