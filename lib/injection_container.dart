import 'package:get_it/get_it.dart';

import 'core/network/dio_client.dart';
import 'features/quotes/data/datasources/quote_remote_datasource.dart';
import 'features/quotes/data/repositories/quote_repository_impl.dart';
import 'features/quotes/domain/repositories/quote_repository.dart';
import 'features/quotes/domain/usecases/get_quotes.dart';
import 'features/quotes/presentation/bloc/quote_bloc.dart';

final sl = GetIt.instance;

void initDependencies() {
  // ── Core ──
  sl.registerLazySingleton(() => DioClient());

  // ── Data Sources ──
  sl.registerLazySingleton<QuoteRemoteDataSource>(
    () => QuoteRemoteDataSourceImpl(sl<DioClient>().dio),
  );

  // ── Repositories ──
  sl.registerLazySingleton<QuoteRepository>(
    () => QuoteRepositoryImpl(sl()),
  );

  // ── Use Cases ──
  sl.registerLazySingleton(() => GetQuotes(sl()));

  // ── BLoC (factory = new instance per screen) ──
  sl.registerFactory(() => QuoteBloc(sl()));
}

