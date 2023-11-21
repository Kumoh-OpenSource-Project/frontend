
import 'package:star_hub/community/model/entity/comment_entity.dart';

class PhotoPostEntity {
  int articleId;
  String title;
  String content;
  List<String> photo;
  String nickName;
  String writeDate;
  String level;
  int likes;
  int clips;
  List<CommentEntity> comments;

  PhotoPostEntity({
    required this.articleId,
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