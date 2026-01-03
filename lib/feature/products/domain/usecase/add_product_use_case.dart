import 'package:dartz/dartz.dart';
import 'package:restapiproduct/feature/products/domain/entity/product_entity.dart';
import 'package:restapiproduct/feature/products/domain/repositories/product_repository.dart';

import '../../../../core/error/failure.dart';

class AddProductUseCase {
  final ProductRepository product;
  AddProductUseCase({required this.product});

  Future<Either<Failure, Unit>> call(ProductEntity productEntity) async {
    return await product.insertProduct(productEntity);
  }
}
