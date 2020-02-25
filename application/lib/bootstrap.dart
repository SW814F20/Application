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
    /*
    di.registerSingleton((_) {
      return Api(environment.getVar('SERVER_HOST'));
    });

    di.registerSingleton((Injector i) {
      return AuthBloc(i.getDependency<Api>());
    });
    */
  }
}
