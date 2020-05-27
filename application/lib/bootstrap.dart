import 'package:application/blocs/ApplicationBloc.dart';
import 'package:application/blocs/AuthenticationBloc.dart';
import 'package:application/blocs/NewTaskBloc.dart';
import 'package:application/blocs/ScreenBloc.dart';
import 'package:application/providers/Sw814Api.dart';
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
      return Sw814Api(environment.getVar('SERVER_HOST'));
    });

    di.registerSingleton((Injector i) {
      return AuthenticationBloc();
    });

    di.registerSingleton((Injector i) {
      return ScreenBloc();
    });

    di.registerSingleton((Injector i) {
      return ApplicationBloc();
    });
    di.registerSingleton((Injector i) {
      return NewTaskBloc();
    });
  }
}
