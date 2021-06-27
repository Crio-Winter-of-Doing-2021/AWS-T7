from .models import Task
from .serializers import TaskSerializer
from django.shortcuts import get_object_or_404
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
# Create your views here.

class AllTasksView(APIView):
    def get(self,request):
        tasks=Task.objects.all().order_by('-id')
        serializer=TaskSerializer(tasks,many=True)
        return Response(serializer.data,status=status.HTTP_200_OK)
    
    def post(self,request):
        serializer = TaskSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            id=serializer.data.get('id')
            obj=get_object_or_404(Task,id=id)
            obj.schedule()
            # return Response({"message":message}, status=status.HTTP_200_OK)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class SingleTaskView(APIView):
    def get(self,request,id):
        obj = get_object_or_404(Task, id = id)
        serializer=TaskSerializer(instance=obj)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    def patch(self,request,id):
        obj = get_object_or_404(Task, id = id)
        serializer=TaskSerializer(instance=obj,partial=True,data=request.data)
        if serializer.is_valid():
            serializer.save()
            obj.schedule()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class ScheduleView(APIView):
    def get(self,request,id):
        obj=get_object_or_404(Task,id=id)
        # obj.update(state="Running")
        message=obj.schedule()
        # obj.save()
        return Response({"message":message}, status=status.HTTP_200_OK)

class CancelView(APIView):
    def patch(self,request,id):
        obj=get_object_or_404(Task,id=id)
        message=obj.cancel()
        return Response({"message":message}, status=status.HTTP_200_OK)

class StatusView(APIView):
    def get(self,request,id):
        obj=get_object_or_404(Task,id=id)
        return Response({"status":obj.state,"output":obj.output},status=status.HTTP_200_OK)

class FilterView(APIView):
    def get(self,reqeuest,needed_state):
        try:
            tasks=Task.objects.filter(state=needed_state)
            serializer=TaskSerializer(tasks,many=True)
            return Response(serializer.data,status=status.HTTP_200_OK)
        except Exception:
            tasks=Task.objects.all().order_by('-id')
            serializer=TaskSerializer(tasks,many=True)
            return Response(serializer.data,status=status.HTTP_200_OK)