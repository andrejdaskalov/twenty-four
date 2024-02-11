import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twenty_four/common_components/text_input.dart';
import 'dart:io';

import '../../dependency_injection/injectable_config.dart';
import 'bloc/add_post_bloc.dart';

class AddPost extends StatelessWidget {
  const AddPost({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Post'),
        ),
        body: BlocProvider<AddPostBloc>(
          create: (context) {
            return getIt.get<AddPostBloc>();
          },
          child: BlocBuilder<AddPostBloc, AddPostState>(
            builder: (context, state) {
              WidgetsBinding.instance.addPostFrameCallback((_){
                if (state.status == SubmitStatus.submitted) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                } else if (state.status == SubmitStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Error submitting post')));
                }
              });
              return ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Image.file(File(imagePath))),
                  ),
                  AddPostForm(
                    onSubmit: (title, description) {
                      BlocProvider.of<AddPostBloc>(context).add(SubmitEvent(
                          title: title,
                          description: description,
                          imagePath: imagePath));
                    },
                  ),
                ],
              );
            },
          ),
        ));
  }
}

class AddPostForm extends StatelessWidget {
  AddPostForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final void Function(String title, String description) onSubmit;
  final TextEditingController titleInputController = TextEditingController();
  final TextEditingController descriptionInputController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TFTextInput(controller: titleInputController, label: 'Title'),
          TFTextInput(
              controller: descriptionInputController, label: "Description"),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                if (titleInputController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Title cannot be empty')));
                  return;
                }
                onSubmit(
                    titleInputController.text, descriptionInputController.text);
              },
              child: const Text('Post!'),
            ),
          )
        ],
      ),
    );
  }
}
