import 'package:charret/application/global_message/global_message.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/src/streams/value_stream.dart';
import 'package:charret/application/models/result.dart';

class GlobalMessageImpl implements GlobalMessage {
  static final GlobalMessageImpl _singleton = GlobalMessageImpl._internal();
  final BehaviorSubject messageSubject = BehaviorSubject();

  factory GlobalMessageImpl() {
    return _singleton;
  }

  GlobalMessageImpl._internal() {
    messageStream = messageSubject.stream;
  }

  @override
  void add(Result result) {
    messageSubject.add(result);
  }

  @override
  late final ValueStream messageStream;
}
