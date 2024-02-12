import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twenty_four/dependency_injection/injectable_config.dart';
import 'package:twenty_four/screens/comments/comments.dart';

import '../../domain/post.dart';
import 'bloc/comment_bloc.dart';

class CommentsButton extends StatelessWidget {
  const CommentsButton({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return BlocProvider(
              create: (context) {
                final bloc = getIt.get<CommentBloc>();
                if (post.id != null) {
                  bloc.add(GetComments(post.id!));
                }
                return bloc;
              },
              child: Container(
                margin: MediaQuery.of(context).viewInsets,
                child: Comments(postId: post.id!),
              ),
            );
          },
          showDragHandle: true,
          isScrollControlled: true,
        );
      },
      icon: const Icon(Icons.comment),
    );
  }
}
