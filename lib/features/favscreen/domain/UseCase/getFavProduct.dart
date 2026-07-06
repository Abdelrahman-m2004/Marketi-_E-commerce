import 'package:marketi/features/favscreen/domain/entites/FavEntity.dart';
import 'package:marketi/features/favscreen/domain/repository/favRepository.dart';

class Getfavproduct {
  final Favrepository repo;

  Getfavproduct({required this.repo});

  Future<Faventity> call() {
    return repo.GetAllFavProducts();
  }
}
