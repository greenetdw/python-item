# -*- coding: utf-8 -*-
# Generated by Django 1.11.10 on 2018-02-21 08:51
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('df_order', '0002_auto_20180221_1634'),
    ]

    operations = [
        migrations.AddField(
            model_name='orderinfo',
            name='zhifu',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='orderinfo',
            name='oaddress',
            field=models.CharField(default='', max_length=150),
        ),
    ]