import 'package:marketi/features/favscreen/domain/entites/FavEntity.dart';

abstract class Favrepository {
  Future<Faventity> GetAllFavProducts();
}
