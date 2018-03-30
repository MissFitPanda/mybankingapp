
from rest_framework import serializers

from .models import Info

# Create your views here.
from django.shortcuts import render


class InfoModelSerializer(serializers.ModelSerializer):

	class Meta:
		model = Info
		fields=[
			'amount',
			'transaction', 

		]