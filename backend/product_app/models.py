from django.db import models

class Login(models.Model):
    username = models.CharField(max_length=100)
    password = models.CharField(max_length=15)
    type = models.CharField(max_length=50)

class Shop(models.Model):
    shop_name = models.CharField(max_length=50)
    owner_name = models.CharField(max_length=100)
    location = models.CharField(max_length=50)
    contact_no = models.CharField(max_length=50)
    email = models.CharField(max_length=50)
    id_proof = models.CharField(max_length=300)
    place = models.CharField(max_length=50)
    district = models.CharField(max_length=50)
    state = models.CharField(max_length=50)
    pin = models.CharField(max_length=10)
    LOGIN = models.ForeignKey(Login,on_delete=models.CASCADE)
    status = models.CharField(max_length=50,default='pending')

class Customer(models.Model):
    c_name = models.CharField(max_length=100)
    number = models.CharField(max_length=50)
    email = models.CharField(max_length=50)
    dob = models.CharField(max_length=50)
    pic = models.CharField(max_length=300)
    place = models.CharField(max_length=50)
    district = models.CharField(max_length=50)
    state = models.CharField(max_length=50)
    pin = models.CharField(max_length=10)
    LOGIN = models.ForeignKey(Login,on_delete=models.CASCADE)


class Delivery_boy(models.Model):
    d_name = models.CharField(max_length=100)
    number = models.CharField(max_length=50)
    email = models.CharField(max_length=50)
    dob = models.CharField(max_length=50)
    pic = models.CharField(max_length=300)
    id_proof = models.CharField(max_length=300)
    place = models.CharField(max_length=50)
    district = models.CharField(max_length=50)
    state = models.CharField(max_length=50)
    pin = models.CharField(max_length=50)
    status = models.CharField(max_length=50,default='pending')
    LOGIN = models.ForeignKey(Login, on_delete=models.CASCADE)

class Feedback(models.Model):
    date = models.DateField(max_length=15)
    CUSTOMER = models.ForeignKey(Customer,on_delete=models.CASCADE)
    feedback = models.CharField(max_length=100)

class Category(models.Model):
    Category_name = models.CharField(max_length=50)
    SHOP = models.ForeignKey(Shop,on_delete=models.CASCADE)

class Product(models.Model):
    Product_name = models.CharField(max_length=50)
    pic = models.CharField(max_length=300)
    price = models.CharField(max_length=50)
    about = models.CharField(max_length=100)
    CATEGORY = models.ForeignKey(Category,on_delete=models.CASCADE)

class Damaged_products(models.Model):
     PRODUCT = models.ForeignKey(Product,on_delete=models.CASCADE)
     date = models.DateField(max_length=15)
     about = models.CharField(max_length=300)
     status = models.CharField(max_length=30,default='pending')
     CUSTOMER = models.ForeignKey(Customer, on_delete=models.CASCADE)

class Stocks(models.Model):
    PRODUCT = models.ForeignKey(Product, on_delete=models.CASCADE)
    s_quntity = models.CharField(max_length = 50)

class Order_main(models.Model):
    request_date = models.DateField(max_length = 15)
    status = models.CharField(max_length=50, default="pending")
    amount = models.CharField(max_length=50)
    CUSTOMER = models.ForeignKey(Customer, on_delete=models.CASCADE)

class Order_sub(models.Model):
    ORDER_MAIN = models.ForeignKey(Order_main,on_delete=models.CASCADE)
    r_quntity = models.CharField(max_length = 50)
    PRODUCT = models.ForeignKey(Product,on_delete=models.CASCADE)

class Assign_order(models.Model):
    DELIVERY = models.ForeignKey(Delivery_boy,on_delete=models.CASCADE)
    status = models.CharField(max_length=50,default="pending")
    date = models.DateField(max_length=15)
    ORDER_SUB = models.ForeignKey(Order_sub,on_delete=models.CASCADE)

class Payments(models.Model):
    ORDER = models.ForeignKey(Order_sub,on_delete=models.CASCADE)
    p_date = models.DateField(max_length=15)
    amnt = models.CharField(max_length=50)
    status = models.CharField(max_length=20,default='')

class Review(models.Model):
    CUSTOMER = models.ForeignKey(Customer,on_delete=models.CASCADE)
    date = models.DateField(max_length=15)
    rating = models.CharField(max_length=100)
    review = models.CharField(max_length=100)
    SHOP = models.ForeignKey(Shop,on_delete=models.CASCADE)

class Offers(models.Model):
    offer_des = models.CharField(max_length=100)
    s_date = models.DateField()
    e_date = models.DateField()
    PRODUCT = models.ForeignKey(Product,on_delete=models.CASCADE)

class Notification(models.Model):
    date = models.DateField(max_length=15)
    notification = models.CharField(max_length=100)
    SHOP = models.ForeignKey(Shop,on_delete=models.CASCADE)

class Cart(models.Model):
    CUSTOMER = models.ForeignKey(Customer,on_delete=models.CASCADE)
    date = models.DateField(max_length=15)
    quantity = models.CharField(max_length=100)
    PRODUCT = models.ForeignKey(Product,on_delete=models.CASCADE)

class Complaint(models.Model):
    CUSTOMER = models.ForeignKey(Customer,on_delete=models.CASCADE)
    complaint = models.CharField (max_length=50)
    date = models.DateField (max_length=15)
    status = models.CharField (max_length=50,default='pending')
    reply = models.CharField (max_length=50)

# class Return(models.Model):
#     date = models.DateField (max_length=15)
#     reason = models.CharField (max_length=500)
#     ORDER = models.ForeignKey(Order_main,on_delete=models.CASCADE)
