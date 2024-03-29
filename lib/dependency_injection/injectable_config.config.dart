// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/comments_api.dart' as _i3;
import '../api/likes_api.dart' as _i4;
import '../api/media_api.dart' as _i6;
import '../api/post_api.dart' as _i7;
import '../api/topic_api.dart' as _i8;
import '../repository/comment_repository.dart' as _i10;
import '../repository/post_repository.dart' as _i11;
import '../repository/topic_repository.dart' as _i9;
import '../screens/add_post/bloc/add_post_bloc.dart' as _i12;
import '../screens/comments/bloc/comment_bloc.dart' as _i13;
import '../screens/main/bloc/main_screen_bloc.dart' as _i14;
import '../service/location_service.dart' as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.CommentsApi>(() => _i3.CommentsApi());
    gh.factory<_i4.LikesApi>(() => _i4.LikesApi());
    gh.factory<_i5.LocationService>(() => _i5.LocationService());
    gh.factory<_i6.MediaApi>(() => _i6.MediaApi());
    gh.factory<_i7.PostApi>(() => _i7.PostApi());
    gh.factory<_i8.TopicApi>(() => _i8.TopicApi());
    gh.factory<_i9.TopicRepository>(
        () => _i9.TopicRepository(gh<_i8.TopicApi>()));
    gh.factory<_i10.CommentRepository>(
        () => _i10.CommentRepository(gh<_i3.CommentsApi>()));
    gh.factory<_i11.PostRepository>(() => _i11.PostRepository(
          gh<_i7.PostApi>(),
          gh<_i6.MediaApi>(),
          gh<_i8.TopicApi>(),
          gh<_i4.LikesApi>(),
          gh<_i5.LocationService>(),
        ));
    gh.factory<_i12.AddPostBloc>(
        () => _i12.AddPostBloc(gh<_i11.PostRepository>()));
    gh.factory<_i13.CommentBloc>(
        () => _i13.CommentBloc(gh<_i10.CommentRepository>()));
    gh.factory<_i14.MainScreenBloc>(() => _i14.MainScreenBloc(
          gh<_i9.TopicRepository>(),
          gh<_i11.PostRepository>(),
        ));
    return this;
  }
}
