import 'package:marketi/features/favscreen/data/RemotDatasourse/favRemotDataSourse.dart';
import 'package:marketi/features/favscreen/domain/entites/FavEntity.dart';
import 'package:marketi/features/favscreen/domain/repository/favRepository.dart';

class favRepositoryImpl implements Favrepository {
  final favRemoteDataSourse favRemoteData;

  favRepositoryImpl({required this.favRemoteData});

  @override
  Future<Faventity> GetAllFavProducts() {
    return favRemoteData.GetAllFavProducts();
  }
}
