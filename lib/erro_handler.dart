class ErrorHandler implements Exception{
  final String errorMessage ;


  @override
  String toString() {
    return 'ErrorHandler{errorMessage: $errorMessage}';
  }

  const ErrorHandler({
    required this.errorMessage,
  });
}