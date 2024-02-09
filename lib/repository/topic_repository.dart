
import 'package:injectable/injectable.dart';

import '../api/topic_api.dart';
import '../domain/topic.dart';

@injectable
class TopicRepository {
  final TopicApi _topicApi;

  TopicRepository(this._topicApi);

  Future<Topic> getTodayTopic() async {
    return _topicApi.getTodayTopic();
  }
}
