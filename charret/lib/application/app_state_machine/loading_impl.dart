import 'package:charret/application/app_state_machine/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LoadingImpl implements Loading {
  LoadingImpl() {
    initFirebase();
  }

  void initFirebase() async {
    await Firebase.initializeApp();
    print(FirebaseAuth.instance.app.name);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
