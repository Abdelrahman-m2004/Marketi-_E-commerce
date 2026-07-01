import 'package:injectable/injectable.dart';
import 'package:marketi/features/profile/domain/repository/profile_repository.dart';

@lazySingleton
class GetThemeUseCase {
  final ProfileRepository repository;
  GetThemeUseCase({required this.repository});
  Future<bool> call() async {
    return repository.getThemeMode();
  }
}
