class FeedbackClass {
  final String feedback;

  FeedbackClass({
    required this.feedback,
  });

  factory FeedbackClass.fromJson(Map<String, dynamic> json) {
    return FeedbackClass(
      feedback: json['feedback'],
    );
  }
}
