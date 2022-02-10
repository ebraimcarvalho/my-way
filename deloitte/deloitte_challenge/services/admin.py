from django.contrib import admin

from .models import Service

@admin.register(Service)
class ServiceAdmin(admin.ModelAdmin):
    list_display = ('title', 'slug', 'created', 'updated')
    prepopulated_fields = {"slug": ("title",)}