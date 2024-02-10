// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/media_api.dart' as _i3;
import '../api/post_api.dart' as _i4;
import '../api/topic_api.dart' as _i6;
import '../repository/post_repository.dart' as _i5;
import '../repository/topic_repository.dart' as _i7;
import '../screens/main/bloc/main_screen_bloc.dart' as _i8;

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
    gh.factory<_i3.MediaApi>(() => _i3.MediaApi());
    gh.factory<_i4.PostApi>(() => _i4.PostApi());
    gh.factory<_i5.PostRepository>(() => _i5.PostRepository(
          gh<_i4.PostApi>(),
          gh<_i3.MediaApi>(),
        ));
    gh.factory<_i6.TopicApi>(() => _i6.TopicApi());
    gh.factory<_i7.TopicRepository>(
        () => _i7.TopicRepository(gh<_i6.TopicApi>()));
    gh.factory<_i8.MainScreenBloc>(() => _i8.MainScreenBloc(
          gh<_i7.TopicRepository>(),
          gh<_i5.PostRepository>(),
        ));
    return this;
  }
}
