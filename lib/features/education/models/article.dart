class Article {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String imageUrl;
  final String category;
  final List<String> likes; // List of user IDs who liked the post

  Article({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.imageUrl,
    required this.category,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'summary': summary,
      'content': content,
      'imageUrl': imageUrl,
      'category': category,
      'likes': likes,
    };
  }

  factory Article.fromMap(String id, Map<String, dynamic> map) {
    return Article(
      id: id,
      title: map['title'] ?? '',
      summary: map['summary'] ?? '',
      content: map['content'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? 'General',
      likes: List<String>.from(map['likes'] ?? []),
    );
  }
}
