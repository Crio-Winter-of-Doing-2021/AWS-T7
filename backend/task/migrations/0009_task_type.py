# Generated by Django 3.1.7 on 2021-06-18 12:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('task', '0008_task_name'),
    ]

    operations = [
        migrations.AddField(
            model_name='task',
            name='type',
            field=models.CharField(choices=[('FILE', 'FILE'), ('URL', 'URL')], default='URL', max_length=4),
        ),
    ]
