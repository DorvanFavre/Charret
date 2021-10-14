import 'state_for_test.dart';

class State2ForTest extends StateForTest {
  @override
  void dispose() {
    print('State 2 disposed');
  }
}
