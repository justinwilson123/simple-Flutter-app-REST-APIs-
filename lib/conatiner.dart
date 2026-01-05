import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import "package:internet_connection_checker_plus/internet_connection_checker_plus.dart";
import 'package:restapiproduct/core/classes/cach_user.dart';
import 'package:restapiproduct/core/classes/crud.dart';
import 'package:restapiproduct/feature/auth/data/data/auth_data.dart';
import 'package:restapiproduct/feature/auth/data/repositories/auth_repositories_imp.dart';
import 'package:restapiproduct/feature/auth/domain/repositories/auth_repository.dart';
import 'package:restapiproduct/feature/auth/domain/usecase/login_use_case.dart';
import 'package:restapiproduct/feature/auth/domain/usecase/logout_use_case.dart';
import 'package:restapiproduct/feature/auth/domain/usecase/profile_use_case.dart';
import 'package:restapiproduct/feature/auth/domain/usecase/signiup_use_case.dart';
import 'package:restapiproduct/feature/auth/presentation/controllers/login/login_cubit.dart';
import 'package:restapiproduct/feature/auth/presentation/controllers/signup/signup_cubit.dart';
import 'package:restapiproduct/feature/products/domain/usecase/add_product_use_case.dart';
import 'package:restapiproduct/feature/products/domain/usecase/get_all_products_use_case.dart';
import 'package:restapiproduct/feature/products/domain/usecase/get_one_product_use_case.dart';
import 'package:restapiproduct/feature/products/domain/usecase/update_product_use_case.dart';
import 'package:restapiproduct/feature/products/presentation/controller/cubit/products_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "core/classes/network_info.dart";
import 'core/classes/save_secure_storage.dart';
import 'feature/products/data/data/remote_data_sources_products.dart';
import 'feature/products/data/repositories/product_repository_imp.dart';
import 'feature/products/domain/repositories/product_repository.dart';
import 'feature/products/domain/usecase/delete_product_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  //=========================== EXTERNAL
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<InternetConnection>(
    () => InternetConnection.createInstance(),
  );
  sl.registerLazySingleton(() => FlutterSecureStorage());
  sl.registerLazySingleton(() => sharedPreferences);
  //=========================== CORE

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));
  sl.registerLazySingleton<CrudInterface>(
    () => CrudHttp(client: sl(), saveSecureStorage: sl()),
  );
  sl.registerLazySingleton<SaveSecureStorage>(
    () => SaveSecureStorage(storage: sl()),
  );
  sl.registerLazySingleton(() => CachUser(sl()));

  //============================ Auth

  sl.registerFactory(() => LoginCubit(loginUseCase: sl(), cachUser: sl()));

  sl.registerFactory(() => SignupCubit(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoriesImp(
      remoteDataSourceAuth: sl(),
      networkInfo: sl(),
      saveSecureStorage: sl(),
      cachUser: sl(),
    ),
  );

  sl.registerLazySingleton<RemoteDataSourceAuth>(
    () => RemoteDataSourceAuthWithHttp(crud: sl(), client: sl()),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ProfileUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));

  //============================ product
  sl.registerFactory(
    () => ProductsCubit(
      getAllProduct: sl(),
      getOneProduct: sl(),
      deleteProduct: sl(),
      updateProduct: sl(),
      addProduc: sl(),
    ),
  );

  sl.registerLazySingleton<ProductRepository>(
    () =>
        ProductRepositoryImp(remoteDataSourceProducts: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<RemoteDataSourceProducts>(
    () => RemoteDataSourcesProductsImp(crud: sl()),
  );

  sl.registerLazySingleton(() => GetAllProductsUseCase(product: sl()));
  sl.registerLazySingleton(() => GetOneProductUseCase(product: sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(proudct: sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(product: sl()));
  sl.registerLazySingleton(() => AddProductUseCase(product: sl()));
}
