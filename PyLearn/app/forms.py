# -*- coding: utf-8 -*-
from django.forms import ModelForm
from app.models import Moment

class MomentForm(ModelForm):
    class Meta:
        model = Moment
        fields = '__all__' #导入所有字段
#         fields = ('content', 'user_name', 'kind')
        




