class ApiResponse<T> {
  T model;
  String errorMessage;
  int code;

  ApiResponse({
    this.model,
    this.errorMessage,
    this.code,
  });
  
  ApiResponse.withError(String val, int code) : model = null, errorMessage = val, code = code;

  @override
  String toString() => 'ApiResponse(model: $model, errorMessage: $errorMessage, code: $code)';
}
