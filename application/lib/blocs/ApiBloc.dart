import 'package:application/providers/Sw814Api.dart';

import '../di.dart';
import 'AuthenticationBloc.dart';

class ApiBloc {
  AuthenticationBloc authenticationBloc = di.getDependency<AuthenticationBloc>();
  Sw814Api api = di.getDependency<Sw814Api>();
}
