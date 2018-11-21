
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
    sql = "select * from common_task_"+city_code+" where workflow=5 and finish_time is null ;"
    print sql
