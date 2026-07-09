import 'package:marketi/core/Network/Api_client.dart';
import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/features/productDetails/data/model/productdetailsModel.dart';
import 'package:marketi/features/productDetails/domain/entites/productDetailsEntity.dart';

class Productdetlremotedatasourse {
  final ApiClient apiClient;

  Productdetlremotedatasourse({required this.apiClient});

  Future<Productdetailsentity> getAllproductDetails(int id) async {
    final response = await apiClient.get(Apiconstant.product_details(id));

    return Productdetailsmodel.fromJson(response.data['data']);
  }
}
