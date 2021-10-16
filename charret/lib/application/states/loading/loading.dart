import 'package:charret/application/states/app_state.dart';
import 'package:charret/application/states/loading/loading_impl.dart';

abstract class Loading extends AppState {
  factory Loading() {
    return LoadingImpl();
  }
}
