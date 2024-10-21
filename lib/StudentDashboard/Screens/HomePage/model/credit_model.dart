/*

  Define Credit Class

 */

class CreditData {
  final String totalCredit;
  final String yourCredit;

  CreditData({required this.totalCredit, required this.yourCredit});

  factory CreditData.fromJson(Map<String, dynamic> json) {
    return CreditData(
      totalCredit: json['total_credit'],
      yourCredit: json['your_credit'],
    );
  }
}
