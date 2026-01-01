from django.core.management.base import BaseCommand
from product_app.models import Login, Shop

class Command(BaseCommand):
    help = 'Creates default admin and shop users'

    def handle(self, *args, **kwargs):
        # Admin
        if not Login.objects.filter(username='admin').exists():
            Login.objects.create(username='admin', password='123', type='admin')
            self.stdout.write(self.style.SUCCESS("Created admin user"))
        else:
            self.stdout.write("Admin user already exists")

        # Shop
        if not Login.objects.filter(username='shop').exists():
            shop_login = Login.objects.create(username='shop', password='123', type='shop')
            Shop.objects.create(
                shop_name='Demo Shop',
                owner_name='Demo Owner',
                location='Kerala',
                contact_no='9876543210',
                email='shop@demo.com',
                id_proof='demo_proof.jpg',
                place='Kochi',
                district='Ernakulam',
                state='Kerala',
                pin='682001',
                LOGIN=shop_login,
                status='approved'
            )
            self.stdout.write(self.style.SUCCESS("Created shop user"))
        else:
            self.stdout.write("Shop user already exists")
