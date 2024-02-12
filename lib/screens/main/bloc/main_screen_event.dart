part of 'main_screen_bloc.dart';

@immutable
abstract class MainScreenEvent {}

class GetTopic extends MainScreenEvent {}

class LikePost extends MainScreenEvent {
  final String postId;

  LikePost(this.postId);
}
