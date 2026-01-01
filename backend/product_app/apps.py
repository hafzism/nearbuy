from django.apps import AppConfig


class ProductAppConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'product_app'

    def ready(self):
        from django.db.models.signals import post_migrate
        from django.dispatch import receiver
        from .models import Login
        
        @receiver(post_migrate)
        def create_default_admin(sender, **kwargs):
            if sender.name == 'product_app':
                if not Login.objects.filter(username='admin').exists():
                    print("Creating default admin user...")
                    Login.objects.create(username='admin', password='123', type='admin')
                    print("Default Admin Created: admin / 123")

                if not Login.objects.filter(username='shop').exists():
                    print("Creating default shop user...")
                    shop_login = Login.objects.create(username='shop', password='123', type='shop')
                    from .models import Shop
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
                    print("Default Shop Created: shop / 123")
