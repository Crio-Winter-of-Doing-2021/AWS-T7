from .models import Task
from .serializers import TaskSerializer
from django.shortcuts import get_object_or_404
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
# Create your views here.

class AllTasksView(APIView):
    # permission_classes = (IsAuthenticated,)
    def get(self,request):
        tasks=Task.objects.all().order_by('-id')
        serializer=TaskSerializer(tasks,many=True)
        return Response(serializer.data,status=status.HTTP_200_OK)
    
    def post(self,request):
        serializer = TaskSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
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
        return Response({"status":obj.state},status=status.HTTP_200_OK)
# @api_view(['GET'])
# def get_all_tasks(request):
#     tasks=Task.objects.all().order_by('-id')
#     serializer=TaskSerializer(tasks,many=True)
#     return Response(serializer.data,status=status.HTTP_200_OK)













# from .models import Task
# from .serializers import TaskSerializer
# from django.shortcuts import get_object_or_404
# from rest_framework import status
# from rest_framework.views import APIView
# from rest_framework.response import Response
# from rest_framework.permissions import IsAuthenticated
# # Create your views here.

# class AllTasksView(APIView):
#     # permission_classes = (IsAuthenticated,)
#     def get(self,request):
#         tasks=Task.objects.all().order_by('-id')
#         serializer=TaskSerializer(tasks,many=True)
#         return Response(serializer.data,status=status.HTTP_200_OK)
    
#     def post(self,request):
#         serializer = TaskSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# class SingleTaskView(APIView):
#     def get(self,request,id):
#         obj = get_object_or_404(Task, id = id)
#         serializer=TaskSerializer(instance=obj)
#         return Response(serializer.data, status=status.HTTP_200_OK)
    
#     def patch(self,request,id):
#         obj = get_object_or_404(Task, id = id)
#         serializer=TaskSerializer(instance=obj,partial=True,data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_200_OK)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# class ScheduleView(APIView):
#     def get(self,reqtest,id):
#         obj=get_object_or_404(Task,id=id)
#         # obj.update(state="Running")
#         obj.schedule()
#         return Response({"message":"Scheduled Successfully. Check console for any output if there."}, status=status.HTTP_200_OK)
# # @api_view(['GET'])
# # def get_all_tasks(request):
# #     tasks=Task.objects.all().order_by('-id')
# #     serializer=TaskSerializer(tasks,many=True)
# #     return Response(serializer.data,status=status.HTTP_200_OK)

