# Generated by Django 3.0.3 on 2020-03-19 19:03

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('spasms', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='tweetrun',
            name='end_date',
            field=models.DateField(default=datetime.datetime(2020, 3, 19, 19, 3, 37, 54705)),
        ),
        migrations.AlterField(
            model_name='tweetrun',
            name='start_date',
            field=models.DateField(default=datetime.datetime(2020, 3, 19, 19, 3, 37, 54650)),
        ),
        migrations.AlterField(
            model_name='twitteruser',
            name='created_at',
            field=models.DateTimeField(default=datetime.datetime(2020, 3, 19, 19, 3, 37, 55558)),
        ),
    ]
