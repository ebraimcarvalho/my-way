from django.views.generic import DetailView, ListView

from .models import Staff

class StaffListView(ListView):
    model = Staff


class StaffDetailView(DetailView):
    model = Staff