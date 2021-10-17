import 'package:charret/application/global_message/global_message_impl.dart';
import 'package:charret/application/models/result.dart';
import 'package:rxdart/rxdart.dart';

abstract class GlobalMessage {
  factory GlobalMessage() {
    return GlobalMessageImpl();
  }

  void add(Result result);
  ValueStream get messageStream;
}
