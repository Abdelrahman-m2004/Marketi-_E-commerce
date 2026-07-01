import 'package:marketi/features/categoryList/categoryModel/Categorymodel.dart';
import 'package:marketi/features/categoryList/data/ApiServices/categoryDataService.dart';

class Categoryrepository {
  final Categorydataservice Apiresponse;

  Categoryrepository(this.Apiresponse);

  Future<List<CategoryModel>> GetAllCategory() async {
    return await Apiresponse.GetAllCategory();
  }
}
