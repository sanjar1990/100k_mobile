class ResponseModel{
  final bool _isError;
  final String _message;
  final dynamic data;

  ResponseModel( {required bool isError, required String message, this.data }) : _isError = isError, _message = message;
  bool get isError=>_isError;
  String get message=>_message;
}