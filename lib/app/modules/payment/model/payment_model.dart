class PaymentModel {
  PaymentModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final String? data;

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      success: json["success"],
      message: json["message"],
      data: json["data"],
    );
  }
}
