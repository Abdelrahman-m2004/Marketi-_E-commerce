class Apiconstant {
  static const String baseUrl = 'http://localhost:8000/api/v1';

  //Auth Endpoint
  static const String register = '/register';
  static const String login = '/login';
  static const String forget_password = '/forgot-password';
  static const String verify_OTP = '/verify-otp';
  static const String reset_password = '/reset-password';
  static const String me = '/me';
  static const String logout = '/logout';

  // Home & catalog EndPoint
  static const String home = '/home';
  static const String search_product = '/search?q=headphones';
  static const String List_category = 'categories';
  static String category_products(int catigory_id) =>
      '/categories/${catigory_id}/products';
  static const String List_Brands = '/brands';
  static const String List_products = '/products';
  static String product_details(int product_id) => '/products/${product_id}';
  static String product_ratings(int product_id) =>
      '/products/${product_id}/ratings';
  static const String delivery_slots = '/delivery-slots';
  static const String FAQs = '/faqs';

  // cart & checkout Endpoint
  static const String view_cart = '/cart';
  static const String add_to_cart = '/cart/items';
  static String updata_cart_item(int item_id) => '/cart/items/${item_id}';
  static const String place_order = '/orders';
  static String Retry_payment_link(int order_id) =>
      '/orders/${order_id}/payment/retry';
  static const String list_order = '/orders';
  static String order_details(int order_id) => '/orders/${order_id}';
  static String cancel_order(int order_id) => '/orders/${order_id}/cancel';

  //payments EndPoint
  static const String List_my_payments = '/payments';
  static String payment_details(int payment_id) => '/payments/${payment_id}';
  static String paypal_success_callback(int payment_id) =>
      '/payments/paypal/success/${payment_id}';
  static const String paypal_webhook = '/payments/paypal/webhook';
  static String mock_checkout(int payment_id) =>
      '/payments/mock/${payment_id}/checkout';
  static String mock_complete_payment(int payment_id) =>
      '/payments/mock/${payment_id}/complete';

  //profile & favourites Endpoint
  static const String get_profile = '/profile';
  static const String update_profile = '/profile';
  static const String change_profile = '/profile/password';
  static const String list_favorites = '/favorites';
  static const String add_favorites = '/favorites';
  static String rate_product(int product_id) =>
      '/products/${product_id}}/ratings';

  // Support & subscriptions Endpoint
  static const String subscription_plans = '/subscription-plans';
  static const String my_subscription = '/subscriptions';
  static const String create_support_ticket = '/support/tickets';
  static const String My_notification = '/notifications';

  //Admin
  static const String dashboard = '/admin/dashboard';
  static const String list_users = '/admin/users';
  static const String list_categories = '/admin/categories';
  static const String create_category = '/admin/categories';
  static const String list_products = '/admin/products';
  static const String list_orders = '/admin/orders';
  static String Update_order_status(int order_id) =>
      '/admin/orders/${order_id}/status';
  static const String paymets_revenue = '/admin/payments/revenue';
  static const String sand_notification = '/admin/notifications';
  static const String support_tickets = '/admin/support/tickets';
}
