class ApiResponse<T> {
  final T? data;
  final String? error;

  ApiResponse._({this.data, this.error});

  factory ApiResponse.success(T data) {
    return ApiResponse._(data: data);
  }

  factory ApiResponse.error(String error) {
    return ApiResponse._(error: error);
  }

  bool get isSuccess => error == null;
}
