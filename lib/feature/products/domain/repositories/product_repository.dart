import 'package:dartz/dartz.dart';
import 'package:restapiproduct/core/error/failure.dart';
import 'package:restapiproduct/feature/products/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, ProductEntity>> getProductById(int id);
  Future<Either<Failure, Unit>> insertProduct(ProductEntity product);
  Future<Either<Failure, Unit>> updateProduct(ProductEntity product);
  Future<Either<Failure, Unit>> deleteProduct(int id);
}
