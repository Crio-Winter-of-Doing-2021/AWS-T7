# Generated by Django 3.1.7 on 2021-04-01 09:21

from django.db import migrations
import django_fsm


class Migration(migrations.Migration):

    dependencies = [
        ('task', '0005_remove_task_state'),
    ]

    operations = [
        migrations.AddField(
            model_name='task',
            name='state',
            field=django_fsm.FSMField(choices=[('Scheduled', 'Scheduled'), ('Running', 'Running'), ('Completed', 'Completed'), ('Failed', 'Failed'), ('Cancelled', 'Cancelled')], default=('Scheduled', 'Scheduled'), max_length=50),
        ),
    ]