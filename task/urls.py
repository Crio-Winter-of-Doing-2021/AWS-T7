from django.urls import path
from .views import AllTasksView, SingleTaskView, ScheduleView

urlpatterns = [
    path('tasks', AllTasksView.as_view()),
    path('tasks/<id>',SingleTaskView.as_view()),
    path('schedule/<id>', ScheduleView.as_view()),
    # path('tasks/create',create_task),
    # path('tasks/<id>',get_task),
    # path('tasks/patch/<id>',update_task),
]