class ResponseAPI {
  final bool status;
  final String message;

  ResponseAPI(
    this.status,
    this.message,
  );

  ResponseAPI.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'];

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };

  @override
  String toString() {
    return 'ResponseAPI{status: $status, message: $message}';
  }
}
