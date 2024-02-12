part of 'main_screen_bloc.dart';


class MainScreenState {
  final Topic? topic;
  final List<Post>? posts;
  final MainScreenStateEnum state;

  MainScreenState({this.posts, this.topic, required this.state});

  MainScreenState copyWith({
    Topic? topic,
    List<Post>? posts,
    MainScreenStateEnum? state,
  }) {
    return MainScreenState(
      topic: topic ?? this.topic,
      posts: posts ?? this.posts,
      state: state ?? this.state,
    );
  }


}

enum MainScreenStateEnum {
  initial,
  loading,
  loaded,
  error,
}
