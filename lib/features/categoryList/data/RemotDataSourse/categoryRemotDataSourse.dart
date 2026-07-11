import 'package:marketi/features/categoryList/data/Model/Categorymodel.dart';
import 'package:marketi/core/Network/Api_client.dart';
import 'package:marketi/core/Network/Apiconstant.dart';

class categoryRemotDataSourse {
  final ApiClient apiClient;
  categoryRemotDataSourse(this.apiClient);
  Future<List<CategoryModel>> GetAllCategory() async {
    final response = await apiClient.get(Apiconstant.List_category);

    final List data = response.data['data'];

    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }
}
