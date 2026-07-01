import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/Network/Api_client.dart';
import 'package:marketi/core/service/service_locator.config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  @lazySingleton
  ApiClient get apiClient => ApiClient();
}
