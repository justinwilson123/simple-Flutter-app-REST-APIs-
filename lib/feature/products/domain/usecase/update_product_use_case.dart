import 'package:dartz/dartz.dart';
import 'package:restapiproduct/core/error/failure.dart';
import 'package:restapiproduct/feature/products/domain/entity/product_entity.dart';
import 'package:restapiproduct/feature/products/domain/repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository product;
  UpdateProductUseCase({required this.product});

  Future<Either<Failure, Unit>> call(ProductEntity productEntity) async {
    return await product.updateProduct(productEntity);
  }
}
