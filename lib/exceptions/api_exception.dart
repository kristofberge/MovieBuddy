class ApiException implements Exception {
  final String _message;

  final String stackTrace;

  String get message => _message;

  ApiException(this._message, {this.stackTrace});
}
