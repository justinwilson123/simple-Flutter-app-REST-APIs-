import 'package:dartz/dartz.dart';
import 'package:restapiproduct/core/error/failure.dart';
import 'package:restapiproduct/feature/products/domain/entity/product_entity.dart';
import 'package:restapiproduct/feature/products/domain/repositories/product_repository.dart';

class GetAllProductsUseCase {
  final ProductRepository product;
  GetAllProductsUseCase({required this.product});
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await product.getAllProducts();
  }
}
