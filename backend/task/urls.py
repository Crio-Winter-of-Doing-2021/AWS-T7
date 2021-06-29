from django.urls import path
from .views import AllTasksView, SingleTaskView, ScheduleView, CancelView, StatusView, FilterView


urlpatterns = [
    path('tasks', AllTasksView.as_view()),
    path('tasks/<id>',SingleTaskView.as_view()),
    path('tasks/schedule/<id>', ScheduleView.as_view()),
    path('tasks/cancel/<id>',CancelView.as_view()),
    path('tasks/status/<id>',StatusView.as_view()),
    path('tasks/filter/<needed_state>',FilterView.as_view()),
]