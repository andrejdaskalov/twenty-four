part of 'add_post_bloc.dart';


class AddPostState {
  final SubmitStatus status;

  AddPostState({required this.status});

  AddPostState copyWith({SubmitStatus? status}) {
    return AddPostState(
      status: status ?? this.status,
    );
  }
}

enum SubmitStatus {
  initial,
  submitted,
  error,
}
