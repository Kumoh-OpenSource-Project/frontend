class PhotoPostEntity {
  String title;
  String content;
  String photo;
  String nickName;
  String writeDate;
  String level;
  int likes;
  int clips;
  int comments;

  PhotoPostEntity({
    required this.title,
    required this.content,
    required this.photo,
    required this.nickName,
    required this.writeDate,
    required this.level,
    required this.likes,
    required this.clips,
    required this.comments,
  });
}