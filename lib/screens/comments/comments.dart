import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twenty_four/common_components/text_input.dart';
import 'package:twenty_four/screens/comments/bloc/comment_bloc.dart';

import '../../domain/comment.dart';

class Comments extends StatelessWidget {
  Comments({super.key, required this.postId});

  final TextEditingController _commentController = TextEditingController();
  final String postId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(8.0),
            child: Text("Comments",
                style: Theme.of(context).textTheme.headlineSmall)),
        Expanded(
          child: BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  return CommentWidget(comment: state.comments[index]);
                },
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                  child: TFTextInput(
                controller: _commentController,
                label: "Add a comment",
              )),
              IconButton.filledTonal(
                onPressed: () {
                  context
                      .read<CommentBloc>()
                      .add(AddComment(postId, _commentController.text));
                  _commentController.clear();
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "User: ${comment.userName}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  )
                ),
                Text("${comment.date.day}.${comment.date.month}.${comment.date.year} ${comment.date.hour.toString().padLeft(2, '0')}:${comment.date.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ))
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(comment.content, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.left)),
        ],
      ),
    );
  }
}
