import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:number_trivia_app_tdd/core/network_info/network_info.dart';
import 'package:number_trivia_app_tdd/core/presentation/utils/input_converter.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/data_sources/local_data_source/local_number_trivia_data_source.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/data_sources/remote_data_source/remote_number_trivia_data_source.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/data_sources/remote_data_source/retrofit/remote_number_retrofit.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/data/repositories/number_trivia_repository.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/repositories/number_trivia_repositoriy.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/use_cases/concret_number_trivia_use_case.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/domain/use_cases/randome_number_trivia_use_case.dart';
import 'package:number_trivia_app_tdd/features/get_number_trivia/presentation/logic/number_trivia_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> setup() async {
  // presentation
  getIt.registerFactory(
    () => NumberTriviaCubit(
      inputConverter: getIt(),
      concreteNumberTriviaUseCase: getIt(),
      randomNumberTriviaUseCase: getIt(),
    ),
  );

  //domain
  getIt.registerLazySingleton(() => ConcreteNumberTriviaUseCase(getIt()));
  getIt.registerLazySingleton(() => RandomNumberTriviaUseCase(getIt()));

  // data
  getIt.registerLazySingleton<NumberTriviaDomainRepository>(
    () => NumberTriviaDataRepository(
      remoteNumberTriviaDataSource: getIt(),
      localNumberTriviaDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton<RemoteNumberTriviaDataSource>(
      () => RemoteNumberTriviaDataSourceImpl(numberRetrofit: getIt()));

  getIt.registerLazySingleton<LocalNumberTriviaDataSource>(
      () => LocalNumberTriviaDataSourceImpl(getIt()));

  getIt.registerLazySingleton(() => RemoteNumberRetrofit(getIt()));
  //core
  getIt.registerLazySingleton(() => InputConverter());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  // third party
  getIt.registerLazySingleton(() => InternetConnectionChecker());
  getIt.registerLazySingleton(() => Dio());
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
