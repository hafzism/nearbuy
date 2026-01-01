"""product_finder URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include

from product_app import views

urlpatterns = [
    path('login/',views.login),
    path('login_post/',views.login_post),
    path('admin_home/',views.admin_home),
    path('admin_view_shop/',views.admin_view_shop),
    path('admin_search_shop/',views.search_shop),
    path('admin_approve_shop/<id>',views.admin_approve_shop),
    path('admin_approved_shops/',views.admin_approved_shop),
    path('admin_search_app_shop/',views.search_app_shop),
    path('admin_reject_shop/<id>',views.admin_reject_shop),
    path('admin_rejected_shops/',views.admin_rejected_shop),
    # path('admin_search_rej_shop/',views.search_rej_shop),

    path('admin_view_dboy/', views.admin_view_dboy),
    path('search_dboy/',views.search_dboy),
    path('admin_approve_dboy/<id>',views.admin_approve_dboy),
    path('search_app_dboy/',views.search_app_dboy),
    path('admin_approved_dboy/',views.admin_approved_dboy),
    path('admin_reject_dboy/<id>',views.admin_reject_dboy),
    path('admin_rejected_dboy/',views.admin_rejected_dboy),
    path('search_rej_dboy/',views.search_rej_dboy),

    path('admin_view_feedback/',views.admin_view_feedback),
    path('search_feed/',views.search_feed),
    path('admin_view_reviews/',views.admin_view_review),
    path('search_review/',views.search_review),
    path('admin_view_customer/',views.admin_view_customers),
    path('search_customer/',views.search_cus),
    path('admin_change_pass/',views.admin_change_password),
    path('admin_change_pass_post/',views.admin_cp_post),
    path('logout/',views.logout),


    path('shop_home/',views.shop_home),
    path('shop_register/',views.shop_reg),
    path('shop_reg_post/',views.shop_reg_post),
    path('shop_view_profile/',views.shop_view_profile),
    path('shop_edit_profile/',views.shop_edit_profile),
    path('view_dboy/', views.view_dboy),
    path('shop_edit_profile_Post/',views.shop_edit_profile_post),
    path('shop_add_category/',views.shop_add_category),
    path('shop_add_category_post/',views.shop_add_category_post),
    path('shop_view_category/',views.shop_view_category),
    path('search_category/',views.search_category),
    path('shop_edit_cat/<id>',views.shop_edit_cat),
    path('shop_edit_cat_post/',views.shop_edit_cat_post),
    path('shop_delete_cat/<id>',views.shop_del_cat),
    path('shop_add_product/',views.shop_add_product),
    path('shop_add_product_post/',views.shop_add_product_post),
    path('shop_view_products/',views.shop_view_product),
    path('search_product/',views.search_product),
    path('shop_edit_product/<id>',views.shop_edit_product),
    path('shop_edit_product_post/',views.shop_edit_product_post),
    path('shop_del_product/<id>',views.shop_del_product),
    path('shop_view_damaged_products/',views.shop_view_damaged_products),
    path('search_damaged_product/',views.search_dproduct),
    path('shop_add_stock/',views.shop_add_stock),
    path('shop_add_stock_post/',views.shop_add_stock_post),
    path('shop_view_stock/',views.shop_view_stock),
    path('search_stock/',views.search_stocks),
    path('shop_edit_stock/<id>',views.shop_edit_stock),
    path('shop_edit_stock_post/',views.shop_edit_stock_post),
    path('shop_delete_stock/<id>',views.shop_del_stock),
    path('shop_view_orders/',views.shop_view_orders),
    path('search_orders/',views.search_orders),
    path('shop_assign_order/<id>',views.shop_assign_order),
    path('shop_assign_post/',views.shop_assign_order_post),
    path('shop_view_delivery_status/',views.shop_view_delivery_boy_status),
    path('search_delivery_status/',views.search_delivery_status),
    path('shop_view_payments/',views.shop_view_payment),
    path('search_payment/',views.search_payment),
    path('shop_view_rating/',views.shop_view_rating),
    path('search_rating/',views.search_rating),
    path('shop_add_offres/',views.shop_add_offer),
    path('shop_offer_post/',views.shop_add_offer_post),
    path('shop_view_offers/',views.shop_view_offers),
    path('search_offers/',views.search_offers),
    path('shop_edit_offers/<id>',views.shop_edit_offers),
    path('shop_edit_post/',views.shop_edit_offer_post),
    path('shop_delete_offers/<id>',views.shop_del_offer),

    path('shop_add_notification/',views.shop_add_notification),
    path('shop_add_notification_post/',views.shop_add_notification_post),
    path('shop_view_notification/',views.shop_view_notification),
    path('search_notification/',views.search_notification),
    path('shop_edit_notification/<id>',views.shop_edit_notification),
    path('shop_edit_notification_post/',views.shop_edit_not_post),
    path('shop_delete_notification/<id>',views.shop_del_not),
    path('shop_view_complaint/',views.shop_view_complaint),
    path('search_complaint/',views.search_complaint),
    path('shop_send_reply/<id>', views.shop_send_reply),
    path('shop_send_reply_post/',views.shop_send_reply_post),
    path('shop_change_pass/',views.shop_change_password),
    path('shop_change_pass_post/',views.shop_cp_post),


    path('user_login_post/',views.user_login_post),
    path('uerregister/',views.userregister),
    path('user_view_profile/',views.user_view_profile),
    path('user_edit_profile/',views.user_edit_profile),
    path('user_view_products/',views.user_view_products),
    path('user_add_to_cart/',views.user_addto_cart),
    path('user_view_cart/',views.user_view_cart),
    path('user_payment/',views.payment),
    path('deletefromcart/',views.user_del_cart),
    path('user_view_orders/',views.user_view_orders),
    path('user_cancel_return/',views.user_cancel_return),
    # path('user_return_product/',views.user_return_product),
    path('user_send_rating/',views.user_add_review),
    path('user_send_complaint/',views.user_send_complaint),
    path('view_reply/',views.userviewreplyoncopmplaints),
    path('user_send_feedback/',views.user_send_feedback),
    path('user_view_feedback/',views.user_view_feedback),
    path('change_pass/',views.user_change_pass),
    path('view_notification/',views.view_not),
    path('view_offers/',views.view_offers),

    path('dboy_register/',views.dboy_register),
    path('dboy_view_profile/', views.dboy_view_profile),
    path('dboy_edit_profile/',views.dboy_edit_profile),
    path('dboy_view_orders/',views.dboy_view_orders),
    path('dboy_change_pass/',views.dboy_change_pass),
    path('dboy_update_status/',views.dboy_update_status),


]
