class ResponseModel {
  final String base;
  final String amount;
  final double result;
  final double rate;

  ResponseModel({
    required this.base,
    required this.amount,
    required this.result,
    required this.rate,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      base: json['base'] as String,
      amount: json['amount'] as String,
      result: (json['result']?['AUD'] ?? 0.0).toDouble(),
      rate: (json['result']?['rate'] ?? 0.0).toDouble(),
    );
  }
}
