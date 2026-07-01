import 'package:marketi/features/favscreen/data/Api/FavRequest.dart';
import 'package:marketi/features/favscreen/favmodels/FavModel.dart';

class Favproductrepo {
  final Favrequest apiRequest;

  Favproductrepo({required this.apiRequest});

  Future<FavModel> GetAllFavProducts() async {
    return await apiRequest.GetAllFavProducts();
  }
}
