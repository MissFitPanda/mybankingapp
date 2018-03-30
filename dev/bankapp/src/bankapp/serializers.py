from rest_framework import generics

# Create your views here.
from info.views import InfoModelSerializer
from info.models import Info


class InfoListAPIView(generics.ListAPIView):
	serializer_class = InfoModelSerializer

	def get_queryset(self):
		return Info.objects.all()