import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twenty_four/screens/main/bloc/main_screen_bloc.dart';

import '../../dependency_injection/injectable_config.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Twenty Four"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO: implement add post
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

              return Text(
                topic.toString(),
                style: TextStyle(
                  color: Color(int.parse(topic.color.replaceFirst("#", "0xFF"))),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
