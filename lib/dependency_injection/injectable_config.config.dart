// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../api/post_api.dart' as _i3;
import '../api/topic_api.dart' as _i5;
import '../repository/post_repository.dart' as _i4;
import '../repository/topic_repository.dart' as _i6;
import '../screens/main/bloc/main_screen_bloc.dart' as _i7;

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
    gh.factory<_i3.PostApi>(() => _i3.PostApi());
    gh.factory<_i4.PostRepository>(() => _i4.PostRepository(gh<_i3.PostApi>()));
    gh.factory<_i5.TopicApi>(() => _i5.TopicApi());
    gh.factory<_i6.TopicRepository>(
        () => _i6.TopicRepository(gh<_i5.TopicApi>()));
    gh.factory<_i7.MainScreenBloc>(() => _i7.MainScreenBloc(
          gh<_i6.TopicRepository>(),
          gh<_i4.PostRepository>(),
        ));
    return this;
  }
}
