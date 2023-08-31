class Comment {
  final String id;
  final String postId;
  final String userId;
  final String text;
  final DateTime timestamp;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.text,
    required this.timestamp,
  });
}
