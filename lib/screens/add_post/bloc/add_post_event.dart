part of 'add_post_bloc.dart';

@immutable
class SubmitEvent {
  final String title;
  final String description;
  final String imagePath;

  const SubmitEvent({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
