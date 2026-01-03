import 'package:dartz/dartz.dart';
import 'package:restapiproduct/feature/products/data/models/products_model.dart';

import '../../../../core/classes/network_info.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../data/remote_data_sources_products.dart';

class ProductRepositoryImp implements ProductRepository {
  final RemoteDataSourceProducts remoteDataSourceProducts;
  final NetworkInfo networkInfo;
  ProductRepositoryImp({
    required this.remoteDataSourceProducts,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> deleteProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSourceProducts.deleteProduct(id);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on NoDataException {
        return Left(NoDataFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceProducts.getAllProduct();
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      } on NoDataException {
        return Left(NoDataFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceProducts.getProductById(id);
        return Right(result);
      } on NoDataException {
        return Left(NoDataFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> insertProduct(ProductEntity product) async {
    final ProductsModel products = ProductsModel(
      id: product.id,
      name: product.name,
      price: product.price,
      isAvailable: product.isAvailable,
    );
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSourceProducts.addProduct(products);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on NoDataException {
        return Left(NoDataFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProduct(ProductEntity product) async {
    final ProductsModel products = ProductsModel(
      id: product.id,
      name: product.name,
      price: product.price!,
      isAvailable: product.isAvailable,
    );
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSourceProducts.updateProduct(product.id!, products);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on NoDataException {
        return Left(NoDataFailure());
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
