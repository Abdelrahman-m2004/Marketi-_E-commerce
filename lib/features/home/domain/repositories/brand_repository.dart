import 'package:marketi/features/home/data/models/brand_model.dart';

abstract class BrandRepository{
    Future<List<BrandModel>> getBrands();
}