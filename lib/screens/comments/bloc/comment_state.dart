part of 'comment_bloc.dart';


class CommentState  {
  CommentStatus status;
  List<Comment> comments;

  CommentState({
    required this.status,
    required this.comments,
  });

  CommentState copyWith({
    CommentStatus? status,
    List<Comment>? comments,
  }) {
    return CommentState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
    );
  }

}


enum CommentStatus { loading, loaded, error }
