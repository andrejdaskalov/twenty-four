import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../repository/post_repository.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

@injectable
class AddPostBloc extends Bloc<SubmitEvent, AddPostState> {
  final PostRepository postRepository;
  AddPostBloc(
    this.postRepository,
      ) : super(AddPostState(status: SubmitStatus.initial)) {
    on<SubmitEvent>((event, emit) {
      postRepository.addPost(event.title, event.description, event.imagePath);
      emit(state.copyWith(status: SubmitStatus.submitted));
    });
  }
}
