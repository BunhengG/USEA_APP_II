class Career {
  final String logo;
  final String position;
  final String organization;
  final String expiredDate;
  final String link;

  Career({
    required this.logo,
    required this.position,
    required this.organization,
    required this.expiredDate,
    required this.link,
  });

  factory Career.fromJson(Map<String, dynamic> json) {
    return Career(
      logo: json['logo'],
      position: json['position'],
      organization: json['organization'],
      expiredDate: json['expired_date'],
      link: json['link'],
    );
  }
}
