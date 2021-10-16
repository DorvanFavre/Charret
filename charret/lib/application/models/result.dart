abstract class Result<T> {
  factory Result.success({T? data, String message = ''}) {
    return Success(data: data, message: message);
  }
  factory Result.failure({String message = ''}) {
    return Failure(message: message);
  }
  Result();
}

class Success<T> extends Result<T> {
  final T? data;
  final String message;

  Success({this.data, this.message = ''});
}

class Failure<T> extends Result<T> {
  final String message;
  Failure({this.message = ''});
}
