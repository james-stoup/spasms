# Generated by Django 3.0.3 on 2020-03-10 18:52

import datetime
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('spasms', '0007_auto_20200310_1707'),
    ]

    operations = [
        migrations.AddField(
            model_name='tweet',
            name='run',
            field=models.ForeignKey(default='', on_delete=django.db.models.deletion.CASCADE, to='spasms.TweetRun'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='twitteruser',
            name='created_at',
            field=models.DateTimeField(default=datetime.datetime(2020, 3, 10, 18, 51, 27, 263310)),
        ),
        migrations.AddField(
            model_name='twitteruser',
            name='description',
            field=models.CharField(default='', max_length=250),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='twitteruser',
            name='favourites',
            field=models.IntegerField(default=''),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='twitteruser',
            name='followers',
            field=models.IntegerField(default=0),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='twitteruser',
            name='statuses',
            field=models.IntegerField(default=''),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='tweetrun',
            name='end_date',
            field=models.DateField(default=datetime.datetime(2020, 3, 10, 18, 51, 27, 262272)),
        ),
        migrations.AlterField(
            model_name='tweetrun',
            name='start_date',
            field=models.DateField(default=datetime.datetime(2020, 3, 10, 18, 51, 27, 262242)),
        ),
    ]
