# Generated by Django 3.1.7 on 2021-03-23 13:53

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('task', '0004_task_state'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='task',
            name='state',
        ),
    ]