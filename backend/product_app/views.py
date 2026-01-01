import datetime

from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect

from product_app.models import *


# Custom Decorator for Route Protection
def login_required(view_func):
    def wrapper(request, *args, **kwargs):
        if 'lid' not in request.session or request.session['lid'] == '':
            return redirect('/product_finder/login/')
        return view_func(request, *args, **kwargs)
    return wrapper

def login(request):
    return render(request, 'index.html')


def login_post(request):
    name = request.POST['nm']
    password = request.POST['ps']

    lobj = Login.objects.filter(username=name, password=password)
    if lobj.exists():
        lobj2 = Login.objects.get(username=name, password=password)
        request.session['lid'] = lobj2.id
        print(f"Login Success: {name} (ID: {lobj2.id}, Type: {lobj2.type})")
        if lobj2.type == 'admin':
            return redirect('/product_finder/admin_home/')
        elif lobj2.type == 'shop':
            return redirect('/product_finder/shop_home/')
        elif lobj2.type == 'customer':
            return redirect('/product_finder/shop_home/')
        else:
            print(f"Login Invalid Type: {lobj2.type}")
            return HttpResponse('''<script>alert("invalid type");window.location='/product_finder/login/'</script>''')
    else:
        print(f"Login Failed for username: '{name}' with password: '{password}'")
        # Check if user exists but wrong password
        if Login.objects.filter(username=name).exists():
           print(f"User '{name}' exists but password did not match.")
        else:
           print(f"User '{name}' does not exist.")
        return HttpResponse('''<script>alert("invalid");window.location='/product_finder/login/'</script>''')


# -----------------------admin-admin-admin-------------

@login_required
def admin_home(request):
    return render(request, 'admin/home_index.html')


@login_required
def admin_view_shop(request):
    obj = Shop.objects.filter(status='pending')
    return render(request, 'admin/view_shop.html', {"data": obj})


@login_required
def search_shop(request):
    srch = request.POST['ss']
    obj = Shop.objects.filter(status='pending', shop_name__icontains=srch)
    return render(request, 'admin/view_shop.html', {"data": obj})


@login_required
def admin_approve_shop(request, id):
    lobj = Login.objects.filter(id=id).update(type='shop')
    obj = Shop.objects.filter(LOGIN=id).update(status='approved')
    return HttpResponse(
        '''<script>alert('approved');window.location='/product_finder/admin_approved_shops/#id'</script>''')


@login_required
def admin_approved_shop(request):
    obj = Shop.objects.filter(status='approved')
    return render(request, 'admin/approved_shop.html', {"data": obj})


@login_required
def search_app_shop(request):
    srch = request.POST['ss']
    obj = Shop.objects.filter(status='approved', shop_name__icontains=srch)
    return render(request, 'admin/approved_shop.html', {"data": obj})



@login_required
def admin_reject_shop(request, id):
    lobj = Login.objects.filter(id=id).update(type='shop')
    obj = Shop.objects.filter(LOGIN=id).update(status='rejected')
    return HttpResponse(
        '''<script>alert('rejected');window.location='/product_finder/admin_rejected_shops/#id'</script>''')


@login_required
def admin_rejected_shop(request):
    obj = Shop.objects.filter(status='rejected')
    return render(request, 'admin/rejected_shop.html', {"data": obj})



#--------------------------------

#--------------------------------

@login_required
def admin_view_dboy(request):
    obj = Delivery_boy.objects.filter(status='pending')
    return render(request, 'admin/view_dboy.html', {"data": obj})


@login_required
def search_dboy(request):
    srch = request.POST['ss']
    obj = Delivery_boy.objects.filter(status='pending', d_name__icontains=srch)
    return render(request, 'admin/view_dboy.html', {"data": obj})


@login_required
def admin_approve_dboy(request,id):
    Login.objects.filter(id=id).update(type='dboy')
    Delivery_boy.objects.filter(LOGIN=id).update(status='approved')
    return HttpResponse('''<script>alert('approved');window.location='/product_finder/admin_approved_dboy/#id'</script>''')


@login_required
def admin_approved_dboy(request):
    obj = Delivery_boy.objects.filter(status='approved')
    return render(request, 'admin/approved_dboy.html', {"data": obj})

@login_required
def search_app_dboy(request):
    srch = request.POST['ss']
    obj = Delivery_boy.objects.filter(status='approved', d_name__icontains=srch)
    return render(request, 'admin/approved_dboy.html', {"data": obj})



@login_required
def admin_reject_dboy(request, id):
    lobj = Login.objects.filter(id=id).update(type='reject')
    obj = Delivery_boy.objects.filter(LOGIN=id).update(status='rejected')
    return HttpResponse(
        '''<script>alert('rejected');window.location='/product_finder/admin_rejected_dboy/#id'</script>''')


@login_required
def admin_rejected_dboy(request):
    obj = Delivery_boy.objects.filter(status='rejected')
    return render(request, 'admin/rejected_dboy.html', {"data": obj})


@login_required
def search_rej_dboy(request):
    srch = request.POST['ss']
    obj = Delivery_boy.objects.filter(status='rejected', d_name__icontains=srch)
    return render(request, 'admin/approved_dboy.html', {"data": obj})

#--------------------------------------------------


@login_required
def admin_view_feedback(request):
    obj = Feedback.objects.all()
    return render(request, 'admin/view_feedback.html', {"data": obj})


@login_required
def search_feed(request):
    fd = request.POST['sdate']
    ed = request.POST['edate']
    obj = Feedback.objects.filter(date__range=[fd, ed])
    return render(request, 'admin/view_feedback.html', {"data": obj})


@login_required
def admin_view_customers(request):
    obj = Customer.objects.all()
    return render(request, 'admin/view_customers.html', {"data": obj})


@login_required
def search_cus(request):
    srch = request.POST['cn']
    obj = Customer.objects.filter(c_name__icontains=srch)
    return render(request, 'admin/view_customers.html', {"data": obj})


@login_required
def admin_view_review(request):
    obj = Review.objects.all()
    return render(request, 'admin/view_review.html', {"data": obj})


@login_required
def search_review(request):
    fd = request.POST['sdate']
    ed = request.POST['edate']
    obj = Review.objects.filter(date__range=[fd, ed])
    return render(request, 'admin/view_review.html', {"data": obj})


@login_required
def admin_change_password(request):
    return render(request, 'admin/change_pass.html')


@login_required
def admin_cp_post(request):
    old = request.POST['op']
    cur = request.POST['np']
    cnew = request.POST['cp']
    id = request.session['lid']

    l = Login.objects.get(id=id)
    if l.password == old:
        if cur == cnew:
            log = Login.objects.filter(id=id).update(password=cnew)
            return HttpResponse(
                '''<script>alert('password updated');window.location='/product_finder/login/'</script>''')
        else:
            return HttpResponse('''<script>alert('ERROR');window.location='/product_finder/login/'</script>''')
    else:
        return HttpResponse('''<script>alert('ERROR');window.location='/product_finder/login/'</script>''')


def logout(request):
    request.session['lid'] = ''
    return redirect('/product_finder/login/')


# -------------------------------shop---shop-------------

@login_required
def shop_home(request):
    return render(request, 'shop/home_index.html')


def shop_reg(request):
    # if request.session['lid'] == '':
    #     return redirect('/product_finder/login')
    return render(request, 'shop/index.html')


def shop_reg_post(request):
    # Checking session is not required for registration
    # if request.session['lid'] == '':
    #     return redirect('/product_finder/login')
    sname = request.POST['sn']
    oname = request.POST['on']
    location = request.POST['loc']
    phno = request.POST['pno']
    email = request.POST['em']

    photo = request.FILES['pr']
    fs = FileSystemStorage()
    d = datetime.datetime.now().strftime('%Y%m%d-%H%M%S') + '.jpg'
    im = fs.save(d, photo)
    path = fs.url(d)

    place = request.POST['plc']
    dist = request.POST['ds']
    state = request.POST['st']
    pin = request.POST['pn']
    psw = request.POST['ps']
    cpsw = request.POST['cps']

    obj = Login.objects.filter(username=email)
    ob = Shop.objects.filter(contact_no=phno)
    if obj.exists():
        return HttpResponse("<script>alert('Email already in use');window.location='/product_finder/shop_register/'</script>")
    elif ob.exists():
        return HttpResponse(
            "<script>alert('Phone already in use');window.location='/product_finder/shop_register/'</script>")
    else:

        lobj = Login()
        lobj.username = email
        lobj.password = psw
        lobj.type = 'pending'
        lobj.save()

        if psw == cpsw:
            obj = Shop()
            obj.shop_name = sname
            obj.owner_name = oname
            obj.location = location
            obj.contact_no = phno
            obj.email = email
            obj.id_proof = path
            obj.place = place
            obj.district = dist
            obj.state = state
            obj.pin = pin
            obj.status = 'pending'
            obj.LOGIN = lobj
            obj.save()
            return HttpResponse('''<script>alert('Registered');window.location='/product_finder/login/'</script>''')
        else:
            return HttpResponse('''<script>alert('Try again');window.location='/product_finder/shop_register/'</script>''')


@login_required
def shop_view_profile(request):
    obj = Shop.objects.get(LOGIN_id=request.session['lid'])
    return render(request, 'shop/view_profile.html', {"data": obj})


@login_required
def shop_edit_profile(request):
    obj = Shop.objects.get(LOGIN_id=request.session['lid'])
    return render(request, 'shop/edit_profile.html', {"data": obj})


@login_required
def shop_edit_profile_post(request):
    obj = Shop.objects.get(LOGIN_id=request.session['lid'])

    try:
        sname = request.POST.get('sn')
        oname = request.POST.get('on')
        location = request.POST.get('loc')
        phno = request.POST.get('pno')
        email = request.POST.get('em')
        place = request.POST.get('plc')
        dist = request.POST.get('ds')
        state = request.POST.get('st')
        pin = request.POST.get('pn')
        
        if not all([sname, oname, location, phno, email, place, dist, state, pin]):
             return HttpResponse("<script>alert('Please fill all fields');window.location='/product_finder/shop_view_profile/'</script>")

        obj = Login.objects.filter(username=email).exclude(id=request.session['lid'])
        ob = Shop.objects.filter(contact_no=phno).exclude(LOGIN_id=request.session['lid'])
        if obj.exists():
            return HttpResponse('''<script>alert('Email already exist');window.location='/product_finder/shop_view_profile/'</script>''')
        elif ob.exists():
            return HttpResponse('''<script>alert('Phone already exist');window.location='/product_finder/shop_view_profile/'</script>''')
        else:

            lobj = Login.objects.get(id=request.session['lid'])
            lobj.username = email
            lobj.save()

            obj = Shop.objects.get(LOGIN_id=request.session['lid'])
            obj.shop_name = sname
            obj.owner_name = oname
            obj.location = location
            obj.contact_no = phno
            obj.email = email
            obj.place = place
            obj.district = dist
            obj.state = state
            obj.pin = pin
            obj.LOGIN_id = request.session['lid']
            
            if 'pr' in request.FILES:
                photo = request.FILES['pr']
                if photo.name != '':
                    fs = FileSystemStorage()
                    d = datetime.datetime.now().strftime('%Y%m%d-%H%M%S') + '.jpg'
                    im = fs.save(d, photo)
                    path = fs.url(d)
                    obj.id_proof = path
            
            obj.save()
            return HttpResponse('''<script>alert('Edited');window.location='/product_finder/shop_view_profile/'</script>''')
    except Exception as e:
        print(f"Error in shop_edit_profile_post: {e}")
        return HttpResponse("<script>alert('Error updating profile');window.location='/product_finder/shop_view_profile/'</script>")


@login_required
def shop_add_category(request):
    return render(request, 'shop/add_categery.html')


@login_required
def shop_add_category_post(request):
    category = request.POST['cat']
    shop = Shop.objects.get(LOGIN_id=request.session['lid'])

    # Check if the category already exists for this shop
    if Category.objects.filter(Category_name=category, SHOP=shop).exists():
        return HttpResponse(
            "<script>alert('Category already exists');window.location='/product_finder/shop_view_category/#id'</script>")

    obj = Category()
    obj.Category_name = category
    obj.SHOP = shop
    obj.save()
    return HttpResponse("<script>alert('Added');window.location='/product_finder/shop_view_category/#id'</script>")


@login_required
def shop_view_category(request):
    obj = Category.objects.filter(SHOP__LOGIN_id=request.session['lid'])
    return render(request, 'shop/view_category.html', {"data": obj})


@login_required
def search_category(request):
    srch = request.POST['ct']
    obj = Category.objects.filter(Category_name__icontains=srch)
    return render(request, 'shop/view_category.html', {"data": obj})


@login_required
def shop_edit_cat(request, id):
    obj = Category.objects.get(id=id)
    return render(request, 'shop/edit_cat.html', {"data": obj})


@login_required
def shop_edit_cat_post(request):
    cname = request.POST['cat']
    id = request.POST['id']

    obj = Category.objects.get(id=id)
    obj.Category_name = cname
    obj.SHOP_id = Shop.objects.get(LOGIN_id=request.session['lid'])
    obj.save()
    return HttpResponse("<script>alert('Edited');window.location='/product_finder/shop_view_category/#id'</script>")


@login_required
def shop_del_cat(request, id):
    obj = Category.objects.get(id=id).delete()
    return HttpResponse("<script>alert('Deleted');window.location='/product_finder/shop_view_category/#id'</script>")


@login_required
def shop_add_product(request):
    res = Category.objects.filter(SHOP__LOGIN_id=request.session['lid'])
    return render(request, 'shop/add_product.html', {'data': res})


@login_required
def shop_add_product_post(request):
    try:
        id = request.POST.get('cat')
        pname = request.POST.get('pn')
        pamnt = request.POST.get('pa')
        pabt = request.POST.get('pd')

        if not all([id, pname, pamnt, pabt]):
             return HttpResponse("<script>alert('Missing fields');window.location='/product_finder/shop_add_product/#id'</script>")

        path = '/static/web/images/default.jpg' # Default or handle error
        if 'pi' in request.FILES:
            pimage = request.FILES['pi']
            if pimage.name != '':
                fs = FileSystemStorage()
                d = datetime.datetime.now().strftime('%Y%m%d-%H%M%S') + '.jpg'
                im = fs.save(d, pimage)
                path = fs.url(d)

        obj = Product()
        obj.pic = path
        obj.Product_name = pname
        obj.about = pabt
        obj.price = pamnt
        obj.CATEGORY_id = id
        obj.save()
        return HttpResponse(
            "<script>alert('Product Added');window.location='/product_finder/shop_view_products/#id'</script>")
    except Exception as e:
        print(f"Error in shop_add_product_post: {e}")
        return HttpResponse("<script>alert('Error adding product');window.location='/product_finder/shop_add_product/#id'</script>")


from django.core.paginator import Paginator


@login_required
def shop_view_product(request):
    data = Product.objects.filter(
        CATEGORY__SHOP__LOGIN_id=request.session['lid'])  # Assuming Product is your model for products
    paginator = Paginator(data, 3)

    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'page_obj': page_obj,
    }
    return render(request, 'shop/view_product.html', context)


@login_required
def search_product(request):
    srch = request.POST['pn']
    obj = Product.objects.filter(Product_name__icontains=srch)
    return render(request, 'shop/view_product.html', {"data": obj})


@login_required
def shop_edit_product(request, id):
    obj = Product.objects.get(id=id)
    drop = Category.objects.all()
    return render(request, 'shop/edit_product.html', {"data": obj, "drop": drop})


@login_required
def shop_edit_product_post(request):
    try:
        id = request.POST.get('id')
        cid = request.POST.get('cat')
        pname = request.POST.get('pn')
        pabt = request.POST.get('pa')
        amnt = request.POST.get('pr')

        obj = Product.objects.get(id=id)

        if 'pi' in request.FILES:
            image = request.FILES['pi']
            if image.name != '':
                fs = FileSystemStorage()
                d = datetime.datetime.now().strftime('%Y%m%d-%H%S%M') + '.jpg'
                im = fs.save(d, image)
                path = fs.url(d)
                obj.pic = path

        obj.Product_name = pname
        obj.price = amnt
        obj.about = pabt
        obj.CATEGORY_id = cid
        obj.save()
        return HttpResponse("<script>alert('Edited');window.location='/product_finder/shop_view_products/'</script>")
    except Exception as e:
        print(f"Error in shop_edit_product_post: {e}")
        return HttpResponse("<script>alert('Error editing product');window.location='/product_finder/shop_view_products/'</script>")


@login_required
def shop_del_product(request, id):
    obj = Product.objects.get(id=id).delete()
    return HttpResponse("<script>alert('Deleted');window.location='/product_finder/shop_view_products/#id'</script>")


def shop_view_damaged_products(request):
    if request.session['lid'] == '':
        return redirect('/product_finder/login')
    obj = Damaged_products.objects.filter(PRODUCT__CATEGORY__SHOP__LOGIN_id=request.session['lid'])
    return render(request, 'shop/damaged_product.html', {"data": obj})


def search_dproduct(request):
    if request.session['lid'] == '':
        return redirect('/product_finder/login')
    srch = request.POST['pn']
    obj = Damaged_products.objects.filter(PRODUCT__Product_name__icontains=srch)
    return render(request, 'shop/damaged_product.html', {"data": obj})


@login_required
def shop_add_stock(request):
    obj = Product.objects.filter(CATEGORY__SHOP__LOGIN_id=request.session['lid'])
    return render(request, 'shop/add_stock.html', {"data": obj})


@login_required
def shop_add_stock_post(request):
    id = request.POST['pn']
    qnt = int(request.POST['pq'])

    if Stocks.objects.filter(PRODUCT_id=id).exists():
        obj = Stocks.objects.get(PRODUCT_id=id)
        obj.s_quntity = int(obj.s_quntity) + qnt
        obj.save()

    else:
        obj = Stocks()
        obj.s_quntity = qnt
        obj.PRODUCT_id = id
        obj.save()

    return HttpResponse("<script>alert('added');window.location='/product_finder/shop_view_stock/#id'</script>")


@login_required
def shop_view_stock(request):
    obj = Stocks.objects.filter(PRODUCT__CATEGORY__SHOP__LOGIN_id=request.session['lid'])
    return render(request, 'shop/view_stock.html', {"data": obj})


@login_required
def search_stocks(request):
    srch = request.POST['pn']
    obj = Stocks.objects.filter(PRODUCT__Product_name__icontains=srch)
    return render(request, 'shop/view_stock.html', {"data": obj})


@login_required
def shop_edit_stock(request, id):
    obj = Stocks.objects.get(id=id)
    obj1 = Product.objects.filter(CATEGORY__SHOP__LOGIN_id=request.session['lid'])
    return render(request, 'shop/edit_stock.html', {"data": obj, "drop": obj1})


@login_required
def shop_edit_stock_post(request):
    id = request.POST['id']
    pid = request.POST['pn']
    stk = request.POST['pq']

    obj = Stocks.objects.get(id=id)
    obj.s_quntity = stk
    obj.PRODUCT_id = pid
    obj.save()
    return HttpResponse("<script>alert('Edited');window.location='/product_finder/shop_view_stock/#id'</script>")


@login_required
def shop_del_stock(request, id):
    obj = Stocks.objects.get(id=id).delete()
    return HttpResponse("<script>alert('Deleted');window.location='/product_finder/shop_view_stock/'</script>")


@login_required
def shop_view_orders(request):
    obj = Order_sub.objects.filter(PRODUCT__CATEGORY__SHOP__LOGIN_id=request.session['lid'])

    for i in obj:
        price = float(i.PRODUCT.price)
        quantity = int(i.r_quntity)
        total_price = price * quantity
        i.total_price = total_price  # Add total_price directly to each item

    return render(request, 'shop/view_orders.html', {"data": obj})


@login_required
def search_orders(request):
    fd = request.POST['sdate']
    ed = request.POST['edate']
    obj = Order_sub.objects.filter(ORDER_MAIN__request_date__range=[fd, ed])
    return render(request, 'shop/view_orders.html', {"data": obj})


@login_required
def shop_assign_order(request, id):
    obj = Delivery_boy.objects.filter(status='approved')
    return render(request, 'shop/assign_order.html', {"data": obj, "id": id})


@login_required
def shop_assign_order_post(request):
    d_boy = request.POST['db']
    date = datetime.datetime.now().strftime("%Y-%m-%d")
    order = request.POST['id']

    # Check if this order is already assigned
    c = Assign_order.objects.filter(ORDER_SUB=order)
    if c.exists():
        return HttpResponse("<script>alert('Order already assigned');window.location='/product_finder/shop_view_delivery_status/#id'</script>")

    # Count how many 'assigned' orders this delivery boy has
    d_count = Assign_order.objects.filter(DELIVERY_id=d_boy, status='assigned').count()
    if d_count >= 5:
        return HttpResponse("<script>alert('This delivery boy already has 5 assigned orders.');window.location='/product_finder/shop_view_orders/#id'</script>")
    else:
        obj = Assign_order()
        obj.DELIVERY_id = d_boy
        obj.ORDER_SUB_id = order
        obj.date = date
        obj.status = 'assigned'
        obj.save()

        Order_main.objects.filter(id=order).update(status='assigned')

        return HttpResponse("<script>alert('Assigned');window.location='/product_finder/shop_view_delivery_status/#id'</script>")


@login_required
def shop_view_delivery_boy_status(request):
    # obj = Assign_order.objects.all()
    obj = Assign_order.objects.filter(ORDER_SUB__PRODUCT__CATEGORY__SHOP__LOGIN_id=request.session['lid'])
    return render(request, 'shop/delivery_boy_status.html', {"data": obj})


@login_required
def search_delivery_status(request):
    fd = request.POST['sdate']
    ed = request.POST['edate']
    obj = Assign_order.objects.filter(date__range=[fd, ed])
    return render(request, 'shop/delivery_boy_status.html', {"data": obj})


def shop_view_payment(request):
    if request.session['lid'] == '':
        return redirect('/product_finder/login')
    obj = Payments.objects.filter(ORDER__PRODUCT__CATEGORY__SHOP__LOGIN_id=request.session['lid'])
    return render(request, 'shop/view_payment.html', {"data": obj})


def search_payment(request):
    if request.session['lid'] == '':
        return redirect('/product_finder/login')
    fd = request.POST['sdate']
    ed = request.POST['edate']
    obj = Payments.objects.filter(p_date__range=[fd, ed])
    return render(request, 'shop/view_payment.html', {"data": obj})


@login_required
def shop_view_rating(request):
    obj = Review.objects.filter(SHOP__LOGIN_id=request.session['lid'])
    return render(request, 'shop/view_rating.html', {"data": obj})


@login_required
def search_rating(request):
    fd = request.POST['sdate']
    ed = request.POST['edate']
    obj = Review.objects.filter(date__range=[fd, ed])
    return render(request, 'shop/view_rating.html', {"data": obj})


@login_required
def shop_add_offer(request):
    obj = Product.objects.all()
    return render(request, 'shop/add_offer.html', {"data": obj})


@login_required
def shop_add_offer_post(request):
    product = request.POST['pr']
    des = request.POST['des']
    sdate = request.POST['sdate']
    edate = request.POST['edate']

    obj = Offers()
    obj.PRODUCT_id = product
    obj.offer_des = des
    obj.s_date = sdate
    obj.e_date = edate
    obj.save()
    return HttpResponse("<script>alert('offer added');window.location='/product_finder/shop_view_offers/#id'</script>")


@login_required
def shop_view_offers(request):
    obj = Offers.objects.filter(PRODUCT__CATEGORY__SHOP__LOGIN_id=request.session['lid'])
    return render(request, 'shop/view_offers.html', {"data": obj})


@login_required
def search_offers(request):
    fd = request.POST['sdate']
    ed = request.POST['edate']
    obj = Offers.objects.filter(e_date__range=[fd, ed])
    return render(request, 'shop/view_offers.html', {"data": obj})


@login_required
def shop_edit_offers(request, id):
    obj = Offers.objects.get(id=id)
    obj2 = Product.objects.all()
    return render(request, 'shop/edit_offers.html', {"data": obj, "data2": obj2})


@login_required
def shop_edit_offer_post(request):
    product = request.POST['pn']
    des = request.POST['od']
    sdate = request.POST['sd']
    edate = request.POST['ed']
    id = request.POST['id']

    obj = Offers.objects.get(id=id)
    obj.PRODUCT_id = product
    obj.offer_des = des
    obj.s_date = sdate
    obj.e_date = edate
    obj.save()
    return HttpResponse(
        "<script>alert('edited successfully');window.location='/product_finder/shop_view_offers/'</script>")


@login_required
def shop_del_offer(request, id):
    obj = Offers.objects.get(id=id).delete()
    return HttpResponse("<script>alert('Deleted');window.location='/product_finder/shop_view_offers/#id'</script>")




@login_required
def view_dboy(request):
    obj = Delivery_boy.objects.filter(status='approved')
    return render(request, 'shop/view_dboy.html', {"data": obj})


@login_required
def shop_add_notification(request):
    return render(request, 'shop/add_notification.html', )


@login_required
def shop_add_notification_post(request):
    notification = request.POST['not']

    obj = Notification()
    obj.notification = notification
    obj.date = datetime.datetime.today()
    obj.SHOP = Shop.objects.get(LOGIN_id=request.session['lid'])
    obj.save()
    return HttpResponse(
        "<script>alert('notification send');window.location='/product_finder/shop_view_notification/#id'</script>")


@login_required
def shop_view_notification(request):
    obj = Notification.objects.filter(SHOP__LOGIN_id=request.session['lid'])
    return render(request, 'shop/view_not.html', {"data": obj})


@login_required
def search_notification(request):
    fd = request.POST['sdate']
    ed = request.POST['edate']
    obj = Notification.objects.filter(date__range=[fd, ed])
    return render(request, 'shop/view_not.html', {"data": obj})


@login_required
def shop_edit_notification(request, id):
    obj = Notification.objects.get(id=id)
    return render(request, 'shop/edit_not.html', {"data": obj})


@login_required
def shop_edit_not_post(request):
    des = request.POST['not']
    id = request.POST['id']

    obj = Notification.objects.get(id=id)
    obj.SHOP_id = id
    obj.notification = des
    obj.date = datetime.datetime.today()
    obj.save()
    return HttpResponse(
        "<script>alert('edited successfully');window.location='/product_finder/shop_view_notification/#id'</script>")


def shop_del_not(request, id):
    if request.session['lid'] == '':
        return redirect('/product_finder/login')
    obj = Notification.objects.get(id=id).delete()
    return HttpResponse("<script>alert('Deleted');window.location='/product_finder/shop_view_offers/#id'</script>")


def shop_view_complaint(request):
    if request.session['lid'] == '':
        return redirect('/product_finder/login')
    obj = Complaint.objects.all()
    return render(request, 'shop/view_complaint.html', {"data": obj})


def search_complaint(request):
    if request.session['lid'] == '':
        return redirect('/product_finder/login')
    fd = request.POST['sdate']
    ed = request.POST['edate']
    obj = Complaint.objects.filter(date__range=[fd, ed])
    return render(request, 'shop/view_complaint.html', {"data": obj})


def shop_send_reply(request, id):
    if request.session['lid'] == '':
        return redirect('/product_finder/login')
    return render(request, 'shop/send_reply.html', {"id": id})


def shop_send_reply_post(request):
    if request.session['lid'] == '':
        return redirect('/product_finder/login')
    rpl = request.POST['rpl']
    rid = request.POST['id']
    obj = Complaint.objects.filter(id=rid).update(reply=rpl, status='replied')
    return HttpResponse("<script>alert('replied');window.location='/product_finder/shop_view_complaint/#id'</script>")


def shop_change_password(request):
    if request.session['lid'] == '':
        return redirect('/product_finder/login')
    return render(request, 'shop/change_pass.html')


def shop_cp_post(request):
    if request.session['lid'] == '':
        return redirect('/product_finder/login')
    old = request.POST['op']
    cur = request.POST['np']
    cnew = request.POST['cp']
    id = request.session['lid']

    l = Login.objects.get(id=id)
    if l.password == old:
        if cur == cnew:
            log = Login.objects.filter(id=id).update(password=cnew)
            return HttpResponse(
                '''<script>alert('password updated');window.location='/product_finder/login/'</script>''')
        else:
            return HttpResponse('''<script>alert('ERROR');window.location='/product_finder/login/'</script>''')
    else:
        return HttpResponse('''<script>alert('ERROR');window.location='/product_finder/login/'</script>''')


# --------user----

def user_login_post(request):
    username = request.POST['username']
    password = request.POST['password']
    lobj = Login.objects.filter(username=username, password=password)
    if lobj.exists():
        lobjj = Login.objects.get(username=username, password=password)
        if lobjj.type == 'user':
            lid = lobjj.id
            return JsonResponse({'status': 'ok', 'lid': str(lid), 'type': 'user'})
        elif lobjj.type == 'dboy':
            lid = lobjj.id
            return JsonResponse({'status': 'ok', 'lid': str(lid), 'type': 'dboy'})
        else:
            return JsonResponse({'status': 'no'})
    else:
        return JsonResponse({'status': 'no'})


def userregister(request):
    name = request.POST['name']
    phone = request.POST['phone']
    email = request.POST['email']

    dob = request.POST['dob']
    place = request.POST['place']
    district = request.POST['district']
    state = request.POST['state']
    pin = request.POST['pin']
    photo = request.POST['image']
    # proof = request.POST['proof']
    password = request.POST['password']
    confirmpassword = request.POST['confirmpassword']

    from datetime import datetime
    import base64
    from django.core.files.base import ContentFile

    date = datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
    a = base64.b64decode(photo)
    
    fs = FileSystemStorage()
    filename = fs.save(f"user/{date}", ContentFile(a))
    path = fs.url(filename)

    # c = base64.b64decode(proof)
    # d1 = datetime.now().strftime("%Y%m%d-%H%M%S") + "1.jpg"
    # fh1 = open(r"C:\Users\hafeez\PycharmProjects\product_finder\media\user\\" + d1 + ".jpg", "wb")
    # path1 = "/media/user/" + d1 + ".jpg"
    # fh1.write(a)
    # fh1.close()

    obj = Login.objects.filter(username=email)
    ob = Customer.objects.filter(number=phone)
    if obj.exists():
        return JsonResponse({"status":"no"})
    elif ob.exists():
        return JsonResponse({"status":"no"})
    else:
        v = Login()
        v.username = email
        v.password = confirmpassword
        v.type = 'user'
        v.save()

        b = Customer()
        b.c_name = name
        b.dob = dob
        b.place = place
        b.pin = pin
        b.district = district
        b.state = state
        b.number = phone
        b.email = email
        b.pic = path
        # b.id_proof = path1
        b.LOGIN = v
        b.save()
        return JsonResponse({"status": "ok"})


def user_view_profile(request):
    lid = request.POST['lid']
    i = Customer.objects.get(LOGIN_id=lid)

    return JsonResponse({"status": "ok", "id": i.id, "name": i.c_name,
                         "place": i.place, "pin": i.pin, "dis": i.district,
                         "state": i.state, "phone": i.number, "email": i.email, "dob": i.dob,
                         "profile": i.pic})




def user_edit_profile(request):
    lid = request.POST['lid']
    name = request.POST['name']
    place = request.POST['place']
    pin = request.POST['pin']
    district = request.POST['district']
    state = request.POST['state']
    phone = request.POST['phone']
    email = request.POST['email']
    profile = request.POST['profile']
    dob = request.POST['dob']
    # proof = request.POST['proof']



    if len(profile) > 5:
        import datetime
        import base64
        from django.core.files.base import ContentFile

        date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
        a = base64.b64decode(profile)
        
        fs = FileSystemStorage()
        filename = fs.save(f"user/{date}", ContentFile(a))
        path = fs.url(filename)
        print(path, '----')

        customer = Customer.objects.get(LOGIN_id=lid)
        customer.pic = path
        customer.save()

    # if len(proof) > 5:
    #     import datetime
    #     import base64
    #     d1 = datetime.datetime.now().strftime("%Y%m%d-%H%M%S") + "1"
    #     a1 = base64.b64decode(proof)
    #     with open(f"C:\\Users\\hafeez\\PycharmProjects\\product_finder\\media\\user\\{d1}.jpg", "wb") as fh1:
    #         path1 = f"/media/user/{d1}.jpg"
    #         fh1.write(a1)
    #         print(path1,'---')
    #
    #     customer = Customer.objects.get(LOGIN_id=lid)
    #     customer.id_proof = path1
    #     customer.save()

    obj = Login.objects.filter(username=email).exclude(id=lid)
    ob = Customer.objects.filter(number=phone).exclude(LOGIN_id=lid)
    if obj.exists():
        return JsonResponse({"status":"no"})
    elif ob.exists():
        return JsonResponse({"status":"no"})
    else:
        customer = Customer.objects.get(LOGIN_id=lid)
        customer.c_name = name
        customer.place = place
        customer.pin = pin
        customer.district = district
        customer.state = state
        customer.number = phone
        customer.email = email
        customer.dob = dob
        customer.save()
        return JsonResponse({"status": "ok"})


# def user_edit_profile(request):
#     lid = request.POST['lid']
#     name = request.POST['name']
#     place = request.POST['place']
#     pin = request.POST['pin']
#     district = request.POST['district']
#     state = request.POST['state']
#     phone = request.POST['phone']
#     email = request.POST['email']
#     image = request.POST['photo']
#     dob = request.POST['dob']
#     id_proof = request.POST['id_proof']
#
#     if len(image) > 5:
#         import datetime
#         import base64
#
#         date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
#         a = base64.b64decode(image)
#         fh = open("C:\\Users\\abhir\\PycharmProjects\\product_finder\\media\\user" + date + ".jpg", "wb")
#
#         path = "/media/user/" + date + ".jpg"
#         fh.write(a)
#         fh.close()
#         a = Customer.objects.get(LOGIN_id=lid)
#         a.image = path
#         a.save()
#
#         d1 = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
#         a1 = base64.b64decode(id_proof)
#         fh1 = open("C:\\Users\\abhir\\PycharmProjects\\product_finder\\media\\user" + date + ".jpg", "wb")
#
#         path1 = "/media/user/" + date + ".jpg"
#         fh1.write(a)
#         fh1.close()
#         a1 = Customer.objects.get(LOGIN_id=lid)
#         a1.id_proof = path1
#         a1.save()
#
#     a = Customer.objects.get(LOGIN_id=lid)
#     a.c_name = name
#     a.place = place
#     a.pin = pin
#     a.district = district
#     a.state = state
#     a.number = phone
#     a.email = email
#     a.dob = dob
#     a.save()
#     return JsonResponse({"status": "ok"})


def user_view_products(request):
    res = Product.objects.all()
    l = []
    for i in res:
        l.append({"id": i.id, "name": i.Product_name, "image": i.pic, "price": i.price, "about": i.about,
                  "cat": i.CATEGORY.Category_name,"shop":i.CATEGORY.SHOP.id,
                  "shopname":i.CATEGORY.SHOP.shop_name,"location":i.CATEGORY.SHOP.location,"place":i.CATEGORY.SHOP.place,
                  "district":i.CATEGORY.SHOP.district,"state":i.CATEGORY.SHOP.state,"contactno":i.CATEGORY.SHOP.contact_no})
    print(l)
    print(i.CATEGORY.SHOP.id)
    return JsonResponse({"status": "ok", 'data': l})



def user_addto_cart(request):
    try:
        lid = request.POST["lid"]
        pid = request.POST["pid"]
        qid = request.POST["qty"]

        print(f"lid: {lid}, pid: {pid}, qid: {qid}")

        s = Stocks.objects.filter(PRODUCT__id=pid).first()
        print("Stock:", s)

        if not s:
            return JsonResponse({"status": "no_stock"})

        # Convert quantities to int
        stock_qty = int(s.s_quntity)
        qid_int = int(qid)

        print(f"Stock Quantity: {stock_qty}, Requested Quantity: {qid_int}")

        if stock_qty < qid_int:
            return JsonResponse({"status": "not_enough_stock"})

        c = Cart()
        c.CUSTOMER = Customer.objects.get(LOGIN_id=lid)
        c.PRODUCT_id = pid
        c.quantity = qid_int
        c.date = datetime.datetime.now()
        c.save()

        print("Cart item added successfully.")
        return JsonResponse({'status': 'ok'})

    except Exception as e:
        print("Error in add to cart:", str(e))
        return JsonResponse({'status': 'error', 'message': str(e)})



def user_view_cart(request):
    lid = request.POST["lid"]


    c = Cart.objects.filter(CUSTOMER__LOGIN_id=lid)
    l = []
    amnt = 0
    py=""
    for i in c:
        st = ""
        s = Stocks.objects.get(PRODUCT_id=i.PRODUCT)
        print(s.s_quntity)
        print(i.quantity)
        if int(i.quantity)>int(s.s_quntity):
            print(st)
            st="no"
            if st=="no":
                py="out"
        amnt += int(i.quantity) * int(i.PRODUCT.price)
        l.append(
            {
                'quantity': i.quantity,
                'date': i.date,
                'name': i.PRODUCT.Product_name,
                'price': i.PRODUCT.price,
                'photo': i.PRODUCT.pic,
                'id': i.id,
                'st':st
            }
        )
    print(l)
    return JsonResponse(
        {
            'status': "ok",
            'data': l,
            'amount': amnt,
            'out': py,
        }
    )




def payment(request):
    lid = request.POST["lid"]
    c = Cart.objects.filter(CUSTOMER__LOGIN_id=lid)

    # Get unique shop IDs
    shop_ids = []
    for item in c:
        shop_id = item.PRODUCT.CATEGORY.SHOP.id
        if shop_id not in shop_ids:
            shop_ids.append(shop_id)

    from datetime import datetime
    for cid in shop_ids:
        cart_items = Cart.objects.filter(CUSTOMER__LOGIN_id=lid, PRODUCT__CATEGORY__SHOP_id=cid)

        total_amount = 0
        # Create Order_main for each shop
        order_main = Order_main()
        order_main.CUSTOMER = Customer.objects.get(LOGIN_id=lid)
        order_main.request_date = datetime.now()
        order_main.amount = '0'
        order_main.save()

        for cart_item in cart_items:
            # Create Order_sub for each product
            order_sub = Order_sub()
            order_sub.r_quntity = cart_item.quantity
            order_sub.PRODUCT = cart_item.PRODUCT
            order_sub.ORDER_MAIN = order_main
            order_sub.save()

            total_amount += int(cart_item.quantity) * float(cart_item.PRODUCT.price)

            # Update stock
            stock = Stocks.objects.get(PRODUCT=cart_item.PRODUCT)
            stock.s_quntity = str(int(stock.s_quntity) - int(cart_item.quantity))
            stock.save()

        # Update Order_main with correct amount
        order_main.amount = str(total_amount)
        order_main.save()

        # Create payment for this shop
        payment_obj = Payments()
        payment_obj.ORDER = order_sub  # Link to last order_sub created
        payment_obj.p_date = datetime.now().date()
        payment_obj.amnt = str(total_amount)
        payment_obj.status = 'paid'
        payment_obj.save()

    # Clear cart
    Cart.objects.filter(CUSTOMER__LOGIN_id=lid).delete()

    return JsonResponse({'status': 'ok'})





# def payment(request):
#     lid = request.POST["lid"]
#     c = Cart.objects.filter(CUSTOMER__LOGIN_id=lid)
#
#     cids = []
#     for item in c:
#         if item.PRODUCT.CATEGORY.id not in cids:
#             cids.append(item.PRODUCT.CATEGORY.SHOP.id)
#
#     total_amount = 0
#     from datetime import datetime
#
#     for cid in cids:
#         cart_items = Cart.objects.filter(CUSTOMER__LOGIN_id=lid,PRODUCT__CATEGORY__SHOP_id=cid)
#
#         order_main = Order_main()
#         order_main.CUSTOMER = Customer.objects.get(LOGIN_id=lid)
#         order_main.request_date = datetime.now()
#         order_main.amount = '0'
#         order_main.save()
#
#         for cart_item in cart_items:
#             print(cart_item)
#
#
#
#             # Create the order sub-item
#             order_sub = Order_sub()
#             order_sub.r_quntity = cart_item.quantity
#             order_sub.PRODUCT = cart_item.PRODUCT
#             order_sub.ORDER_MAIN = order_main
#             order_sub.save()
#
#             # Update total amount
#             total_amount += float(cart_item.quantity) * float(cart_item.PRODUCT.price)
#
#             # Update stock quantity
#             stock = Stocks.objects.get(PRODUCT=cart_item.PRODUCT)
#             stock.s_quntity = str(int(stock.s_quntity) - int(cart_item.quantity))
#             stock.save()
#
#             # Create the payment entry
#             obj = Payments()
#             obj.ORDER_id = order_sub.id
#             obj.p_date = datetime.now().today()
#             obj.amnt = total_amount
#             obj.status = 'paid'
#             obj.save()
#         # oid = order_main.id
#     o = Order_main.objects.filter(id=order_main).update(amount = str(total_amount))
#         # o.amount = str(total_amount)
#         # o.save()
#
#     # Clear the cart after processing
#     Cart.objects.filter(CUSTOMER__LOGIN_id=lid).delete()
#
#     return JsonResponse({
#         'status': 'ok'
#     })


# def payment(request):
#     lid = request.POST["lid"]
#     c = Cart.objects.filter(CUSTOMER__LOGIN_id=lid)
#
#     cids = []
#     for item in c:
#         if item.PRODUCT.CATEGORY.id not in cids:
#             cids.append(item.PRODUCT.CATEGORY.id)
#
#         total_amount = 0
#
#     from datetime import datetime
#     for cid in cids:
#         cart_items = Cart.objects.filter(CUSTOMER=lid, PRODUCT__CATEGORY_id=cid)
#
#         order_main = Order_main()
#         order_main.CUSTOMER = Customer.objects.get(LOGIN_id=lid)
#         order_main.request_date = datetime.now()
#         order_main.amount = '0'
#         order_main.save()
#
#
#         for cart_item in cart_items:
#             print(cart_item)
#             order_sub = Order_sub()
#             order_sub.r_quntity = cart_item.quantity
#             order_sub.PRODUCT = cart_item.PRODUCT
#             order_sub.ORDER_MAIN = order_main
#             order_sub.save()
#
#             total_amount += float(cart_item.quantity) * float(cart_item.PRODUCT.price)
#
#             obj = Payments()
#             obj.ORDER_id = order_sub.id
#             obj.p_date = datetime.now().today()
#             obj.amnt = total_amount
#             obj.status = 'paid'
#             obj.save()
#
#
#         order_main.amount = str(total_amount)
#         order_main.save()
#
#
#     Cart.objects.filter(CUSTOMER__LOGIN_id=lid).delete()
#
#
#     return JsonResponse({
#         'status': 'ok'
#     })


def user_del_cart(request):
    id = request.POST['cid']
    obj = Cart.objects.get(id=id).delete()
    return JsonResponse({
        'status': 'ok'
    })


def user_view_orders(request):
    lid = request.POST["lid"]
    print(lid, '---')
    print('---------')
    o = Order_sub.objects.filter(ORDER_MAIN__CUSTOMER__LOGIN_id=lid)
    print(o, '----')

    l = []

    for i in o:
        product_price = float(i.PRODUCT.price)
        quantity = int(i.r_quntity)
        total_price = product_price * quantity

        l.append({
            'id': i.id,
            'qnt': quantity,
            'name': i.PRODUCT.Product_name,
            'price': total_price,  # Correct total price per item
            'date': i.ORDER_MAIN.request_date,
            'ostatus': i.ORDER_MAIN.status,
            'pid': i.PRODUCT.id,
            'oid': i.ORDER_MAIN.id
        })

    print(l, '----')

    return JsonResponse({
        'status': 'ok',
        'data': l
    })



def user_cancel_return(request):
    lid = request.POST['lid']
    reason = request.POST['reason']
    pid = request.POST['pid']

    pp=Order_sub.objects.get(id=pid).PRODUCT.id

    print(pid)
    print("------------")
    obj = Damaged_products()
    obj.CUSTOMER_id = Customer.objects.get(LOGIN_id=lid).id
    obj.date = datetime.datetime.today()
    obj.status = 'report sent to shop'
    obj.about = reason
    obj.PRODUCT_id = pp
    # print(pid)
    obj.save()

    e=Order_sub.objects.get(id=pid).ORDER_MAIN.id
    Order_main.objects.filter(id=e).update(status='Report sent to shop')

    return JsonResponse({"status":"ok"})




def user_add_review(request):
    lid = request.POST["lid"]
    review = request.POST["review"]
    rating = request.POST["rating"]
    planid = request.POST["planid"]
    print(lid)
    print(planid)
    print('koo')

    r = Review()
    r.CUSTOMER = Customer.objects.get(LOGIN_id=lid)
    r.SHOP_id = planid
    r.date = datetime.datetime.today()
    r.review = review
    r.rating = rating
    r.save()

    return JsonResponse({'status': 'ok'})


def user_send_complaint(request):

    lid= request.POST["lid"]
    complaint = request.POST["complaint"]
    from  datetime import  datetime
    f=Complaint()
    f.CUSTOMER = Customer.objects.get(LOGIN_id=lid)
    f.complaint = complaint
    f.date = datetime.now()
    f.status = 'pending'
    f.reply = 'pending'
    f.save()

    return  JsonResponse(
        {
            'status':'ok'
        }
    )



def userviewreplyoncopmplaints(request):
    lid=request.POST['lid']
    res=Complaint.objects.filter(CUSTOMER__LOGIN_id=lid)
    l=[]
    for i in res:
        l.append({"id":i.id,"complaint":i.complaint,"reply":i.reply,"date":i.date,})
    return JsonResponse({"status":"ok","data":l})



def user_send_feedback(request):

    lid= request.POST["lid"]
    feedback = request.POST["feedback"]
    from  datetime import  datetime
    f=Feedback()
    f.CUSTOMER = Customer.objects.get(LOGIN_id=lid)
    f.feedback = feedback
    f.date = datetime.now()
    f.save()

    return  JsonResponse(
        {
            'status':'ok'
        }
    )



def user_view_feedback(request):
    lid=request.POST['lid']
    res=Feedback.objects.filter(CUSTOMER__LOGIN_id=lid)
    l=[]
    for i in res:
        l.append({"id":i.id,"feedback":i.feedback,"date":i.date,})
    return JsonResponse({"status":"ok","data":l})



def user_change_pass(request):
    old = request.POST['op']
    cur = request.POST['np']
    cnew = request.POST['cp']
    id = request.POST['lid']

    l = Login.objects.get(id=id)
    if l.password == old:
        if cur == cnew:
            log = Login.objects.filter(id=id).update(password=cnew)
            return JsonResponse({"status":"ok"})
        else:
            return JsonResponse({"status":"no"})
    else:
        return ({"status":"no"})



def view_not(request):
    res=Notification.objects.all()

    l=[]
    for i in res:
        l.append({"id":i.id,"not":i.notification,"date":i.date,"shop":i.SHOP.shop_name})
    return JsonResponse({"status":"ok","data":l})



def view_offers(request):
    res=Offers.objects.all()
    l=[]
    for i in res:
        l.append({"id":i.id,"sdate":i.s_date,"edate":i.e_date,"des":i.offer_des,"pname":i.PRODUCT.Product_name})
    return JsonResponse({"status":"ok","data":l})



# def user_return_product(request):
#     oid = request.POST['oid']
#     reason = request.POST['reason']
#
#     r = Return()
#     r.date = datetime.datetime.now().today()
#     r.reason = reason
#     r.ORDER_id = oid
#     r.save()
#
#     o = Order_main.objects.get(id=oid)
#     o.status = 'returned'
#     o.save()
#     return JsonResponse({"status": "ok",})

#-------------------------------------------delivery boy-----------------------------------------------



def dboy_register(request):
    name = request.POST['name']
    phone = request.POST['phone']
    email = request.POST['email']
    dob = request.POST['dob']
    place = request.POST['place']
    district = request.POST['district']
    state = request.POST['state']
    pin = request.POST['pin']
    photo = request.POST['image']
    proof = request.POST['proof']
    password = request.POST['password']
    confirmpassword = request.POST['confirmpassword']

    from datetime import datetime
    import base64
    from django.core.files.base import ContentFile

    date = datetime.now().strftime("%Y%m%d-%H%M%S")
    
    fs = FileSystemStorage()

    # Save Profile Photo
    a = base64.b64decode(photo)
    file_name = f"user/{date}.jpg"
    saved_name = fs.save(file_name, ContentFile(a))
    path = fs.url(saved_name)

    # Save Proof
    c = base64.b64decode(proof)
    file_name_proof = f"user/{date}1.jpg"
    saved_name_proof = fs.save(file_name_proof, ContentFile(c))
    path1 = fs.url(saved_name_proof)


    obj = Login.objects.filter(username=email)
    ob = Delivery_boy.objects.filter(number=phone)
    if obj.exists():
        return JsonResponse({"status":"no"})
    elif ob.exists():
        return JsonResponse({"status":"no"})
    else:
            v = Login()
            v.username = email
            v.password = confirmpassword
            v.type = 'dboy'
            v.save()

            b = Delivery_boy()
            b.d_name = name
            b.dob = dob
            b.place = place
            b.pin = pin
            b.district = district
            b.state = state
            b.number = phone
            b.email = email
            b.pic = path
            b.id_proof = path1
            b.LOGIN = v
            b.save()
            return JsonResponse({"status": "ok"})


def dboy_view_profile(request):
    lid = request.POST['lid']
    i = Delivery_boy.objects.get(LOGIN_id=lid)

    return JsonResponse({"status": "ok", "id": i.id, "name": i.d_name,
                         "place": i.place, "pin": i.pin, "dis": i.district,
                         "state": i.state, "phone": i.number, "email": i.email, "dob": i.dob,
                         "photo": i.pic, "photo1": str(i.id_proof)})


def dboy_edit_profile(request):
    lid = request.POST['lid']
    name = request.POST['name']
    place = request.POST['place']
    pin = request.POST['pin']
    district = request.POST['district']
    state = request.POST['state']
    phone = request.POST['phone']
    email = request.POST['email']
    image = request.POST['photo']
    dob = request.POST['dob']
    id_proof = request.POST['id_proof']

    if len(image) > 5:
        import datetime
        import base64
        from django.core.files.base import ContentFile

        date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
        a = base64.b64decode(image)
        
        fs = FileSystemStorage()
        saved_name = fs.save(f"user/{date}.jpg", ContentFile(a))
        path = fs.url(saved_name)
        
        d = Delivery_boy.objects.get(LOGIN_id=lid)
        d.pic = path # Changed from image to pic as per model usage elsewhere, assuming model field is pic based on dboy_register
        d.save()
        
    if len(id_proof) > 5:
        import datetime
        import base64
        from django.core.files.base import ContentFile
        
        date = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
        a1 = base64.b64decode(id_proof)
        
        fs = FileSystemStorage()
        saved_name1 = fs.save(f"user/{date}1.jpg", ContentFile(a1))
        path1 = fs.url(saved_name1)

        d = Delivery_boy.objects.get(LOGIN_id=lid)
        d.id_proof = path1
        d.save()

    obj = Login.objects.filter(username=email).exclude(id=lid)
    ob = Delivery_boy.objects.filter(number=phone).exclude(LOGIN_id=lid)
    if obj.exists():
        return JsonResponse({"status":"no"})
    elif ob.exists():
        return JsonResponse({"status":"no"})
    else:
        a = Delivery_boy.objects.get(LOGIN_id=lid)
        a.c_name = name
        a.place = place
        a.pin = pin
        a.district = district
        a.state = state
        a.number = phone
        a.email = email
        a.dob = dob
        a.save()
        return JsonResponse({"status": "ok"})


from django.http import JsonResponse

def dboy_view_orders(request):
    lid = request.POST["lid"]
    # Filter the orders based on the delivery boy's login ID
    orders = Assign_order.objects.filter(DELIVERY__LOGIN_id=lid,status='assigned')

    result_list = []

    # Iterate through each order and prepare the response data
    for order in orders:
        result_list.append(
            {
                'id': order.id,
                'cname': order.ORDER_SUB.ORDER_MAIN.CUSTOMER.c_name,
                'qnt': order.ORDER_SUB.ORDER_MAIN.CUSTOMER.place,
                'pname': order.ORDER_SUB.PRODUCT.CATEGORY.SHOP.shop_name,
                'price': order.ORDER_SUB.ORDER_MAIN.CUSTOMER.number,  # Ensure you're accessing this properly
                'date': order.date  # Assuming 'date' is a field in Assign_order
            }
        )

    # Return a JSON response with status and the data
    return JsonResponse(
        {
            'status': 'ok',
            'data': result_list
        }
    )



def dboy_change_pass(request):
    old = request.POST['op']
    cur = request.POST['np']
    cnew = request.POST['cp']
    id = request.POST['lid']

    l = Login.objects.get(id=id)
    if l.password == old:
        if cur == cnew:
            log = Login.objects.filter(id=id).update(password=cnew)
            return JsonResponse({"status":"ok"})
        else:
            return JsonResponse({"status":"no"})
    else:
        return ({"status":"no"})


def dboy_update_status(request):
    id = request.POST['cid']

    # 1. Update Assign_order status
    Assign_order.objects.filter(id=id).update(status='delivered')

    # 2. Get related Order_main through Order_sub
    assigned_order = Assign_order.objects.get(id=id)               # Get Assign_order object
    order_sub = assigned_order.ORDER_SUB                           # Get related Order_sub
    order_main = order_sub.ORDER_MAIN                              # Get related Order_main
    order_main.status = 'delivered'                                # Update status
    order_main.save()                                              # Save changes

    return JsonResponse({'status': 'ok'})

