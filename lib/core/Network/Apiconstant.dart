class Apiconstant {
  static const String baseUrl      = 'https://marketi.newcinderella.online/api/v1';
  static const String imageBaseUrl = 'https://marketi.newcinderella.online/storage/';

  // Auth Endpoint
  static const String register        = '/register';
  static const String login           = '/login';
  static const String forget_password = '/forgot-password';
  static const String verify_OTP      = '/verify-otp';
  static const String reset_password  = '/reset-password';
  static const String me              = '/me';
  static const String logout          = '/logout';

  // Home & catalog EndPoint
  static const String home           = '/home';
  static const String search_product = '/search?q=headphones';
  static const String List_category  = '/categories';
  static String category_products(int categoryId) => '/categories/$categoryId/products';
  static const String List_Brands    = '/brands';
  static const String List_products  = '/products';
  static String product_details(int productId) => '/products/$productId';
  static String product_ratings(int productId) => '/products/$productId/ratings';
  static const String delivery_slots = '/delivery-slots';
  static const String FAQs           = '/faqs';

  // Cart & checkout Endpoint
  static const String view_cart   = '/cart';
  static const String add_to_cart = '/cart/items';
  static String updata_cart_item(int itemId) => '/cart/items/$itemId';
  static const String place_order = '/orders';
  static String Retry_payment_link(int orderId) => '/orders/$orderId/payment/retry';
  static const String list_order = '/orders';
  static String order_details(int orderId) => '/orders/$orderId';
  static String cancel_order(int orderId)  => '/orders/$orderId/cancel';

  // Payments EndPoint
  static const String List_my_payments = '/payments';
  static String payment_details(int paymentId)         => '/payments/$paymentId';
  static String paypal_success_callback(int paymentId) => '/payments/paypal/success/$paymentId';
  static const String paypal_webhook                   = '/payments/paypal/webhook';
  static String mock_checkout(int paymentId)           => '/payments/mock/$paymentId/checkout';
  static String mock_complete_payment(int paymentId)   => '/payments/mock/$paymentId/complete';

  // Profile & favourites Endpoint
  static const String get_profile    = '/profile';
  static const String update_profile = '/profile';
  static const String change_profile = '/profile/password';
  static const String list_favorites = '/favorites';
  static const String add_favorites  = '/favorites';
  static String rate_product(int productId) => '/products/$productId/ratings';

  // Support & subscriptions Endpoint
  static const String subscription_plans    = '/subscription-plans';
  static const String my_subscription       = '/subscriptions';
  static const String create_support_ticket = '/support/tickets';
  static const String My_notification       = '/notifications';

  // Admin
  static const String dashboard       = '/admin/dashboard';
  static const String list_users      = '/admin/users';
  static const String list_categories = '/admin/categories';
  static const String create_category = '/admin/categories';
  static const String list_products   = '/admin/products';
  static const String list_orders     = '/admin/orders';
  static String Update_order_status(int orderId) => '/admin/orders/$orderId/status';
  static const String paymets_revenue   = '/admin/payments/revenue';
  static const String sand_notification = '/admin/notifications';
  static const String support_tickets   = '/admin/support/tickets';
}
