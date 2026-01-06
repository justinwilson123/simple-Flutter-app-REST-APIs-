import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restapiproduct/core/error/failure.dart';
import 'package:restapiproduct/feature/products/domain/entity/product_entity.dart';
import 'package:restapiproduct/feature/products/domain/usecase/add_product_use_case.dart';
import 'package:restapiproduct/feature/products/domain/usecase/delete_product_use_case.dart';
import 'package:restapiproduct/feature/products/domain/usecase/get_all_products_use_case.dart';
import 'package:restapiproduct/feature/products/domain/usecase/get_one_product_use_case.dart';
import 'package:restapiproduct/feature/products/domain/usecase/update_product_use_case.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetAllProductsUseCase getAllProduct;
  final GetOneProductUseCase getOneProduct;
  final DeleteProductUseCase deleteProduct;
  final UpdateProductUseCase updateProduct;
  final AddProductUseCase addProduc;
  ProductsCubit({
    required this.getAllProduct,
    required this.getOneProduct,
    required this.deleteProduct,
    required this.updateProduct,
    required this.addProduc,
  }) : super(ProductsInitial());

  getAllPoduct() async {
    emit(state.copyWith(messageError: "", products: [], messageSuccess: ""));
    final either = await getAllProduct.call();
    either.fold(
      (failure) {
        if (failure is OffLineFailure) {
          emit(
            state.copyWith(
              isLoading: false,
              messageError: "No Internet Connection",
            ),
          );
        } else if (failure is NoDataFailure) {
          emit(state.copyWith(isLoading: false, messageError: "No Data"));
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              messageError: "Some thing is Wrong",
            ),
          );
        }
      },
      (products) {
        emit(
          state.copyWith(
            isLoading: false,
            messageError: "",
            products: products,
          ),
        );
      },
    );
  }

  isAvailable(bool isAvailable) {
    emit(
      state.copyWith(
        isAvailable: isAvailable,
        messageError: "",
        messageSuccess: "",
      ),
    );
  }

  addProduct({required String name, required int price}) async {
    emit(state.copyWith(messageError: "", messageSuccess: ""));
    final productEntity = ProductEntity(
      name: name,
      price: price,
      isAvailable: false,
    );
    final either = await addProduc.call(productEntity);
    either.fold(
      (failure) {
        if (failure is OffLineFailure) {
          emit(
            state.copyWith(
              isLoading: false,
              messageError: "No Internet Connection",
            ),
          );
        } else if (failure is NoDataFailure) {
          emit(state.copyWith(isLoading: false, messageError: "No Data"));
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              messageError: "Some thing is Wrong",
            ),
          );
        }
      },
      (_) {
        emit(
          state.copyWith(
            isLoading: false,
            messageError: "",
            messageSuccess: "Product Added",
          ),
        );
      },
    );
  }

  deleteOneProduct(int id) async {
    emit(state.copyWith(messageError: "", messageSuccess: ""));
    final either = await deleteProduct.call(id);
    either.fold(
      (failure) {
        if (failure is OffLineFailure) {
          emit(
            state.copyWith(
              isLoading: false,
              messageError: "No Internet Connection",
            ),
          );
        } else if (failure is NoDataFailure) {
          emit(state.copyWith(isLoading: false, messageError: "No Data"));
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              messageError: "Some thing is Wrong",
            ),
          );
        }
      },
      (_) {
        List<ProductEntity> copyProducts = List.from(state.products);
        final index = copyProducts.indexWhere((element) => element.id == id);
        copyProducts.removeAt(index);
        List<ProductEntity> newProducts = List.from(copyProducts);
        emit(
          state.copyWith(
            isLoading: false,
            messageError: "",
            messageSuccess: "Product Deleted",
            products: newProducts,
          ),
        );
      },
    );
  }

  updateProdcut({
    required int id,
    required String name,
    required String price,
  }) async {
    emit(state.copyWith(messageError: "", messageSuccess: ""));
    final productEntity = ProductEntity(
      id: id,
      name: name,
      price: int.parse(price),
      isAvailable: state.isAvailable,
    );
    print(productEntity);
    final either = await updateProduct.call(productEntity);
    either.fold(
      (failure) {
        if (failure is OffLineFailure) {
          emit(
            state.copyWith(
              isLoading: false,
              messageError: "No Internet Connection",
            ),
          );
        } else if (failure is NoDataFailure) {
          emit(state.copyWith(isLoading: false, messageError: "No Data"));
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              messageError: "Some thing is Wrong",
            ),
          );
        }
      },
      (_) {
        emit(
          state.copyWith(
            isLoading: false,
            messageError: "",
            messageSuccess: "Product Updated",
          ),
        );
      },
    );
  }
}
