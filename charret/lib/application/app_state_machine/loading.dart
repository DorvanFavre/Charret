import 'package:charret/application/app_state_machine/loading_impl.dart';

import 'app_state.dart';

abstract class Loading extends AppState {
  factory Loading() {
    return LoadingImpl();
  }
}
