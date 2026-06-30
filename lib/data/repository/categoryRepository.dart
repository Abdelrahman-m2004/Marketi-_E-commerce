import 'package:marketi/class/Categorymodel.dart';
import 'package:marketi/data/ApiServices/categoryDataService.dart';

class Categoryrepository {
  final Categorydataservice Apiresponse;

  Categoryrepository(this.Apiresponse);

  Future<List<CategoryModel>> GetAllCategory() {
    return Apiresponse.GetAllCategory();
  }
}
