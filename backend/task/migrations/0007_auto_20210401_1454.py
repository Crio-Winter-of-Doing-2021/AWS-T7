# Generated by Django 3.1.7 on 2021-04-01 09:24

from django.db import migrations
import django_fsm


class Migration(migrations.Migration):

    dependencies = [
        ('task', '0006_task_state'),
    ]

    operations = [
        migrations.AlterField(
            model_name='task',
            name='state',
            field=django_fsm.FSMField(default='Scheduled', max_length=50),
        ),
    ]