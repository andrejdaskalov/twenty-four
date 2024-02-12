part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class GetComments extends CommentEvent {
  final String postId;

  GetComments(this.postId);
}

class AddComment extends CommentEvent {
  final String postId;
  final String content;

  AddComment(this.postId, this.content);
}
