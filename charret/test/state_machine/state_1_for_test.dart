import 'state_for_test.dart';

class State1ForTest extends StateForTest {
  @override
  void dispose() {
    print('State 1 disposed');
  }
}
