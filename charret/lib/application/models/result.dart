abstract class Result<T> {
  factory Result.success({T? data, String message = ''}) {
    return Success(data: data, message: message);
  }
  factory Result.failure({String message = ''}) {
    return Failure(message: message);
  }
  Result({required this.message});
  final String message;
}

class Success<T> extends Result<T> {
  final T? data;

  Success({this.data, String message = ''}) : super(message: message);
}

class Failure<T> extends Result<T> {
  Failure({String message = ''}) : super(message: message);
}
