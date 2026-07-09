import 'package:marketi/features/productDetails/domain/entites/productDetailsEntity.dart';
import 'package:marketi/features/productDetails/domain/repository/productDetailsRepository.dart';

class Getallprouductdet {
  final Productdetailsrepository repo;

  Getallprouductdet({required this.repo});

  Future<Productdetailsentity> call(int id) {
    return repo.getAllProductDetails(id);
  }
}
