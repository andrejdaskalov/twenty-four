import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twenty_four/screens/main/bloc/main_screen_bloc.dart';

import '../../dependency_injection/injectable_config.dart';
import '../../domain/post.dart';
import '../add_post/camera_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TwentyFour"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CameraScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocProvider(
          create: (BuildContext context) {
            var instance = getIt.get<MainScreenBloc>();
            instance.add(GetTopic());
            return instance;
          },
          child: BlocBuilder<MainScreenBloc, MainScreenState>(
            builder: (BuildContext context, MainScreenState state) {
              var topic = state.topic;
              if (topic == null) {
                return const Text("no topic");
              }

              return Column(
                children: [
                  Text(
                    topic.toString(),
                    style: TextStyle(
                      color: Color(int.parse(topic.color.replaceFirst("#", "0xFF"))),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.posts?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return CardPost(post: state.posts![index]);
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
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
              :
          Image.network(post.mediaURIs[0]),
          Text(post.title),
          Text(post.description),
        ],
      ),
    );
  }
}
