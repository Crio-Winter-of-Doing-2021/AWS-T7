from django.db import models
from threading import Timer
from django_fsm import FSMField
import requests
# Create your models here.
STATES = ('Scheduled', 'Running', 'Completed', 'Failed', 'Cancelled')
# STATES = list(zip(STATES, STATES))

def upload_location(instance, filename):
	file_path = 'files/{filename}'.format(filename=filename)
	return file_path

class Task(models.Model):
    TYPE_OF_FUNCTION_CHOICES = [
        ('FILE','FILE'),
        ('URL','URL')
    ]
    
    type = models.CharField(
        max_length=4,
        choices=TYPE_OF_FUNCTION_CHOICES,
        default='URL',
    )
    state = FSMField(default="Scheduled")
    time=models.IntegerField()
    url=models.URLField(max_length=1200,null=True,blank=True)
    name=models.CharField(max_length=120)
    file=models.FileField(null=True,blank=True,upload_to=upload_location)
    
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
        if self.type=="URL":
            url=self.url
            req=requests.get(url) 
            print("\n"*10,req.json())
        else:
            print(self.file)
            code=bytes(self.file.read()).decode("utf-8") 
            exec(code)
        self.state="Completed"
        super().save()

    def cancel(self):
        if self.state=="Scheduled":
            self.state="Cancelled"
            super().save()
            return "Schedulling Cancelled"
        return "You cannot cancel a running or already completed lambda function"