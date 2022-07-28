class ProcessResponse<T>{
  String message;
  bool success;
  T? object;

  ProcessResponse({required this.message, required this.success, this.object});
}