import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/Network/Api_client.dart';
import 'service_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  ApiClient get apiClient => ApiClient();
}
