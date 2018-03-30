from django.db import models

# Create your models here.
class Info(models.Model):
	#user = models.ForeignKey(settings.AUTH_USER_MODEL)
	transaction = models.FloatField(null=False, blank=False)
	amount = models.FloatField(blank=True)
	Cards = models.TextField(null=True, blank=True)


	def __str__(self):
		return str(self.id)
	  