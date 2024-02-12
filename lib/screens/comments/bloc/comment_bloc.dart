import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:twenty_four/repository/comment_repository.dart';

import '../../../domain/comment.dart';

part 'comment_event.dart';
part 'comment_state.dart';

@injectable
class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository _commentRepository;

  CommentBloc(
    this._commentRepository,
      ) : super(CommentState(status: CommentStatus.loading, comments: [])) {
    on<GetComments>((event, emit) async {
      final comments = await _commentRepository.getCommentsByPostId(event.postId);
      emit(state.copyWith(status: CommentStatus.loaded, comments: comments));
    });

    on<AddComment>((event, emit) async {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      await _commentRepository.addComment(event.postId, userId, event.content);
      add(GetComments(event.postId));
    });
  }
}
