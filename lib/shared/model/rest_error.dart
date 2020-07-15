class RestError {
  String message;

  RestError({this.message});

  factory RestError.fromData(String msg) => RestError(
        message: msg,
      );
}
