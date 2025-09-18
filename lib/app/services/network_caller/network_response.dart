class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic responseData;
  final String errorMessage;
  final String message;

  NetworkResponse( 
      {required this.isSuccess,
      required this.statusCode,
      this.responseData,
      this.message = 'Response message',
      this.errorMessage = 'Something went wrong'});
}