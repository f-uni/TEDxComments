class Talk {
  final String id;
  final String speakers;
  final String title;
  final String url;
  final String description;
  final String duration;
  final DateTime publishedAt;
  final List<dynamic> tags;
  final String imageUrl;
  final List<dynamic> relatedVideo;
  final String views;
  final dynamic comments;

  Talk.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap["_id"] ?? "",
        speakers = jsonMap["speakers"] ?? "",
        title = jsonMap["title"] ?? "",
        url = jsonMap["url"] ?? "",
        description = jsonMap["description"] ?? "",
        duration = jsonMap["duration"] ?? "0",
        publishedAt =
            DateTime.parse(jsonMap["publishedAt"] ?? "2000-01-01T00:00:00Z"),
        tags = jsonMap["tags"] ?? [],
        imageUrl = jsonMap["img_url"],
        relatedVideo = jsonMap["related_videos"] ?? [],
        views = jsonMap["views"] ?? "0",
        comments = jsonMap["comments"] ?? {"info":[], "disc":[], "extra":[]};
}
