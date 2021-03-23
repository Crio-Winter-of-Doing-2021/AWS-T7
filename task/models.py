from django.db import models
from threading import Timer
from django_fsm import FSMField, transition
import requests
# Create your models here.
STATES = ('Scheduled', 'Running', 'Completed', 'Failed', 'Cancelled')
STATES = list(zip(STATES, STATES))

class Task(models.Model):
    # state = FSMField(default=STATES[0], choices=STATES)
    # state=models.CharField(max_length=20,default="Schdeuled")
    time=models.IntegerField()
    url=models.URLField(max_length=1200)

    # @transition(field=state,source='Scheduled',target='Running')
    def schedule(self):
        # self.state="Running"
        delay=self.time//100
        t=Timer(delay,self.scheduler)
        t.start()

    # @transition(field=state,source='Running',target='Completed')
    def scheduler(self):
        # self.state="Completed"
        url=self.url
        req=requests.get(url) 
        print("\n"*10,req.json())
    
