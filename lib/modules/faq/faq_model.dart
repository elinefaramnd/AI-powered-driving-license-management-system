class FaqItem {
  final int id;
  final String category;
  final String question;
  final String answer;

  FaqItem({
    required this.id,
    required this.category,
    required this.question,
    required this.answer,
  });

  factory FaqItem.fromJson(Map<String, dynamic> json) {
    return FaqItem(
      id: json['id'] ?? 0,
      category: json['category'] ?? '',
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}
