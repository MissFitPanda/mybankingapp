# -*- coding: utf-8 -*-
# Generated by Django 1.11.11 on 2018-03-18 09:38
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Info',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('transaction', models.FloatField()),
                ('Amount', models.FloatField()),
                ('Cards', models.CharField(max_length=16)),
            ],
        ),
    ]
