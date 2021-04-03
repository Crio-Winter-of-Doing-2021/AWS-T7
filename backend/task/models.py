from django.db import models
from threading import Timer
from django_fsm import FSMField
import requests
# Create your models here.
STATES = ('Scheduled', 'Running', 'Completed', 'Failed', 'Cancelled')
# STATES = list(zip(STATES, STATES))

class Task(models.Model):
    state = FSMField(default="Scheduled")
    time=models.IntegerField()
    url=models.URLField(max_length=1200)
    name=models.CharField(max_length=120)

    def schedule(self):
        if self.state=="Scheduled":
            delay=self.time//100
            t=Timer(delay,self.handler)
            t.start()
            return "Scheduled Successfully. Check console for any output if there."
        return "Lambda state!=Scheduled "
            
    def handler(self):
        self.state="Running"
        super().save()
        url=self.url
        req=requests.get(url) 
        print("\n"*10,req.json())
        self.state="Completed"
        super().save()

    def cancel(self):
        if self.state=="Scheduled":
            self.state="Cancelled"
            super().save()
            return "Schedulling Cancelled"
        return "You cannot cancel a running or already completed lambda function"