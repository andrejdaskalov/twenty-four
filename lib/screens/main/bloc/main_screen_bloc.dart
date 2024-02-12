import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:twenty_four/repository/topic_repository.dart';

import '../../../domain/post.dart';
import '../../../domain/topic.dart';
import '../../../repository/post_repository.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';
@injectable
class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final TopicRepository topicRepository;
  final PostRepository postRepository;

  MainScreenBloc(
      this.topicRepository, this.postRepository,
      ) : super(MainScreenState(state: MainScreenStateEnum.loading)) {
    on<MainScreenEvent>((event, emit) async {
      emit(MainScreenState(state: MainScreenStateEnum.loading));
      final topic = await topicRepository.getTodayTopic();
      final posts = await postRepository.getPostsByTopicId(topic.id);
      emit(MainScreenState(topic: topic, posts: posts, state: MainScreenStateEnum.loaded));
    });
  }
}