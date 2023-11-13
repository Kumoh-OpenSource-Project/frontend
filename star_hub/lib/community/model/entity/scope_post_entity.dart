import 'package:star_hub/community/model/entity/comment_entity.dart';

class ScopePostEntity {
  String title;
  String content;
  String nickName;
  String writeDate;
  String level;
  int likes;
  int clips;
  List<CommentEntity> comments;

  ScopePostEntity({
  required this.title,
  required this.content,
  required this.nickName,
  required this.writeDate,
  required this.level,
  required this.likes,
  required this.clips,
  required this.comments,
  });

}

