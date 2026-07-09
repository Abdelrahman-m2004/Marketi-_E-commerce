import 'package:marketi/features/productDetails/data/dataSourse/productDetlRemoteDataSourse.dart';
import 'package:marketi/features/productDetails/domain/entites/productDetailsEntity.dart';
import 'package:marketi/features/productDetails/domain/repository/productDetailsRepository.dart';

class Productdetailsrepositoryimpl implements Productdetailsrepository {
  final Productdetlremotedatasourse remotData;

  Productdetailsrepositoryimpl({required this.remotData});
  @override
  Future<Productdetailsentity> getAllProductDetails(int id) {
    return remotData.getAllproductDetails(id);
  }
}
