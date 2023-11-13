
import 'package:star_hub/community/model/entity/comment_entity.dart';

class PhotoPostEntity {
  String title;
  String content;
  String photo;
  String nickName;
  String writeDate;
  String level;
  int likes;
  int clips;
  List<CommentEntity> comments;

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