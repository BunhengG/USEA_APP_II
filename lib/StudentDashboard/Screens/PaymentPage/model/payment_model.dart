class PaymentClass {
  final String invoiceNumber;
  final String paymentDate;
  final String amountPaid;
  final String remainingAmount;

  PaymentClass({
    required this.invoiceNumber,
    required this.paymentDate,
    required this.amountPaid,
    required this.remainingAmount,
  });

  factory PaymentClass.fromJson(Map<String, dynamic> json) {
    return PaymentClass(
      invoiceNumber: json['invoice_num'] ?? '',
      paymentDate: json['pdate'] ?? '',
      amountPaid: json['money_paid'] ?? '',
      remainingAmount: json['money_rem'] ?? '',
    );
  }
}

// Class representing study year payments
class PayStudy {
  final String year;
  final String fullPrice;
  final String discount;
  final String finalPrice;
  final String paid;
  final String remaining;
  final List<PaymentClass> invoices;

  PayStudy({
    required this.year,
    required this.fullPrice,
    required this.discount,
    required this.finalPrice,
    required this.paid,
    required this.remaining,
    required this.invoices,
  });

  factory PayStudy.fromJson(Map<String, dynamic> json) {
    // Ensure 'invoices' is present and is a list
    var invoicesJson = json['invoices'] as List? ?? [];
    List<PaymentClass> invoicePayments =
        invoicesJson.map((i) => PaymentClass.fromJson(i)).toList();

    return PayStudy(
      year: json['year'] ?? '',
      fullPrice: json['fullprice'] ?? '',
      discount: json['discount'] ?? '',
      finalPrice: json['finalprice'] ?? '',
      paid: json['paid'] ?? '',
      remaining: json['remain'] ?? '',
      invoices: invoicePayments,
    );
  }
}

class OtherPayment {
  final String invoiceDate;
  final String invoiceNumber;
  final String paidAmount;
  final String currency;
  final String remainingAmount;
  final String paymentDate;
  final String moneyPaid;
  final String moneyToPay;

  OtherPayment({
    required this.invoiceDate,
    required this.invoiceNumber,
    required this.paidAmount,
    required this.currency,
    required this.remainingAmount,
    required this.paymentDate,
    required this.moneyPaid,
    required this.moneyToPay,
  });

  factory OtherPayment.fromJson(Map<String, dynamic> json) {
    return OtherPayment(
      invoiceDate: json['invoice_date'] ?? '',
      invoiceNumber: json['o_invoice'] ?? '',
      paidAmount: json['paid'] ?? '',
      currency: json['currency'] ?? '',
      remainingAmount: json['o_money_rem'] ?? '',
      paymentDate: json['o_pdate'] ?? '',
      moneyPaid: json['o_money_paid'] ?? '',
      moneyToPay: json['o_money_pay'] ?? '',
    );
  }
}
