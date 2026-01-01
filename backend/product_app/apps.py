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
