import 'package:dartz/dartz.dart';
import 'package:restapiproduct/feature/products/domain/repositories/product_repository.dart';

import '../../../../core/error/failure.dart';

class DeleteProductUseCase {
  final ProductRepository proudct;
  DeleteProductUseCase({required this.proudct});
  Future<Either<Failure, Unit>> call(int id) async {
    return await proudct.deleteProduct(id);
  }
}
