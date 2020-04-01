import 'package:application/blocs/ApplicationBloc.dart';
import 'package:application/blocs/AuthenticationBloc.dart';
import 'package:application/providers/BaseApi.dart';
import 'package:injector/injector.dart';
import 'package:application/di.dart';
import 'package:application/providers/environment_provider.dart' as environment;

/// Bootstrap the project
class Bootstrap {
  /// Register all dependencies here. Here the construction of everything that
  /// can be injected with the container.
  ///
  /// NB:
  /// Singleton restricts the instantiation of a class to one 'single' instance
  static void register() {
    di.registerSingleton((_) {
      return BaseApi(environment.getVar('SERVER_HOST'));
    });

    di.registerSingleton((Injector i) {
      return AuthenticationBloc();
    });

    di.registerSingleton((Injector i) {
      final ApplicationBloc bloc = ApplicationBloc();
      return bloc;
    });
  }
}
