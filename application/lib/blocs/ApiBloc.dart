import 'package:application/providers/BaseApi.dart';

import '../di.dart';
import 'AuthenticationBloc.dart';

class ApiBloc {
  AuthenticationBloc authenticationBloc = di.getDependency<AuthenticationBloc>();
  BaseApi api = di.getDependency<BaseApi>();
}
