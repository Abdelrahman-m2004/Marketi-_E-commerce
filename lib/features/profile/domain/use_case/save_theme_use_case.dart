import 'package:injectable/injectable.dart';
import 'package:marketi/features/profile/domain/repository/profile_repository.dart';

@lazySingleton
class SaveThemeUseCase {
  final ProfileRepository repository;
  SaveThemeUseCase({required this.repository});
  Future<void> call(bool isDark) async {
    return repository.saveThemeMode(isDark);
  }
}
