from django.views.generic import DetailView, ListView

from .models import Service

class ServiceListView(ListView):
    model = Service


class ServiceDetailView(DetailView):
    model = Service