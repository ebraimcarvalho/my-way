from django.contrib.auth.models import User
from django.db import models

class Staff(models.Model):
    name = models.CharField(max_length=255)
    department = models.CharField(max_length=255)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-created",)

    def __str__(self):
        return self.name