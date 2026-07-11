import 'package:marketi/features/productDetails/domain/entites/productDetailsEntity.dart';

abstract class Productdetailsrepository {
  Future<Productdetailsentity> getAllProductDetails(int id);
}
