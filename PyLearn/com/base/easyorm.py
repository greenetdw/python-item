# -*- coding: UTF-8 -*-
#pip install peewee

from peewee import *

db = SqliteDatabase("sampleDB.db")

class BaseModel(Model):
    class Meta:
        database = db
        
class Course(BaseModel):
    id = PrimaryKeyField()
    title = CharField(null = False)
    period = IntegerField()
    description = CharField()
    class Meta:
        order_by = ('title',)
        db_table = 'course'
        
class Teacher(BaseModel):
    id = PrimaryKeyField()
    name = CharField(null = False)
    gender = BooleanField()
    address = CharField()
    course_id = ForeignKeyField(Course, to_field='id', related_name='course')
    class Meta:
        order_by = ('name',)
        db_table = 'teacher'
    
# if __name__ == '__main__':
    
#     Course.create_table()
#     Teacher.create_table()    
#     
#     Course.create(id = 1, title = '经济学', period = 320, description='文科理科都可以修')
#     Course.create(id = 2, title = '文学', period = 300, description='文科都可以修')
    
#     record = Course.get(id = 1)
#     print record.title, record.period

#     record.period = 200
#     record.save()

#     record.delete_instance()
    
#     courses = Course.select()

#     courses = Course.select().where(Course.id < 10).order_by(Course.period.desc())
#        
#     for course in  courses:
#         print course.period   

#     total = Course.select(fn.Avg("period")).alias('avg_period')
    
#     Course.update(period=300).where(Course.id>2).execute()

#     res = Course.select().join(Teacher).where(Teacher.gender == True)
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    