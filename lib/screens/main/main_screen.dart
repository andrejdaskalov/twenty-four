import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:twenty_four/screens/main/bloc/main_screen_bloc.dart';

import '../../dependency_injection/injectable_config.dart';
import '../../domain/post.dart';
import '../add_post/camera_screen.dart';
import '../comments/comments_modal.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> onRefresh(BuildContext context) async {
      final bloc = context.read<MainScreenBloc>();
      debugPrint("From Refresh: ${bloc.hashCode}");
      var stream = bloc.stream.firstWhere((state) =>
          state.state == MainScreenStateEnum.loaded ||
          state.state == MainScreenStateEnum.error);
      bloc.add(GetTopic());
      await stream;
      return Future.value();
    }

    return BlocProvider(
      create: (context) {
        var instance = getIt.get<MainScreenBloc>();
        debugPrint("From Provider: ${instance.hashCode}");
        instance.add(GetTopic());
        return instance;
      },
      child: Builder(// needed to provide a context with the blocprovider bloc,
          // so that the context.read<MainScreenBloc>() can be used
          builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("TwentyFour"),
            actions: [
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  GoRouter.of(context).go("/login");
                },
                icon: const Icon(Icons.account_circle_outlined),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CameraScreen()));
            },
            child: const Icon(Icons.add),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RefreshIndicator(
              onRefresh: () {
                return onRefresh(context);
              },
              child: BlocBuilder<MainScreenBloc, MainScreenState>(
                builder: (BuildContext context, MainScreenState state) {
                  final bloc = context.read<MainScreenBloc>();
                  debugPrint("From Builder: ${bloc.hashCode}");
                  var topic = state.topic;
                  if (topic == null) {
                    return const Text("no topic");
                  } else if (state.state == MainScreenStateEnum.error) {
                    return const Text("Error");
                  }

                  return Column(
                    children: [
                      Text(
                        topic.toString(),
                        style: TextStyle(
                          color: Color(
                              int.parse(topic.color.replaceFirst("#", "0xFF"))),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: state.posts?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return CardPost(post: state.posts![index]);
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}

class CardPost extends StatelessWidget {
  final Post post;

  const CardPost({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        (post.mediaURIs.isEmpty)
            ? const Text("No media")
            : Image.network(post.mediaURIs[0]),
        Text(post.title),
        Text(post.description),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LikeButton(post: post),
            CommentsButton(post: post),
          ],
        )
      ],
    ));
  }
}

class LikeButton extends StatelessWidget {
  const LikeButton({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        onPressed: () {
          final bloc = context.read<MainScreenBloc>();
          bloc.add(LikePost(post.id!));
        },
        padding: const EdgeInsets.all(10),
        icon: post.likedByUser
            ? const Icon(Icons.thumb_up_alt)
            : const Icon(Icons.thumb_up_outlined),
      ),
      Text(post.likes.toString()),
    ]);
  }
}


