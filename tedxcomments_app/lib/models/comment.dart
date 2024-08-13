class Comment {
  final String id;
  final String userId;
  final int timestamp;
  final String title;
  final String body;
  final int upvote;

  Comment.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap["comment_id"] ?? "",
        userId = jsonMap["user_id"] ?? "",
        timestamp = jsonMap["timestamp"] ?? 0,
        title = jsonMap["title"] ?? "",
        body = jsonMap["body"] ?? "",
        upvote = jsonMap["upvote"] ?? 0;
        
}