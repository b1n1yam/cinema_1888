class APIResponse<T> {
  T data;
  String errorMessage;
  bool error;

  APIResponse({this.data, this.errorMessage, this.error = false});
}
