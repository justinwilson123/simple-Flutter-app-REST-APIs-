import 'package:dartz/dartz.dart';
import 'package:restapiproduct/core/error/failure.dart';
import 'package:restapiproduct/feature/products/domain/entity/product_entity.dart';
import 'package:restapiproduct/feature/products/domain/repositories/product_repository.dart';

class GetOneProductUseCase {
  final ProductRepository product;
  GetOneProductUseCase({required this.product});

  Future<Either<Failure, ProductEntity>> call(int id) async {
    return await product.getProductById(id);
  }
}
