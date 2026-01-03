part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final List<ProductEntity> products;
  final String messageError;
  final bool isLoading;
  final ProductEntity product;
  final bool isAvailable;
  final String messageSuccess;

  const ProductsState({
    this.products = const [],
    this.messageError = "",
    this.isLoading = true,
    this.product = const ProductEntity(id: 0, name: "name"),
    this.isAvailable = false,
    this.messageSuccess = "",
  });

  ProductsState copyWith({
    List<ProductEntity>? products,
    String? messageError,
    bool? isLoading,
    ProductEntity? product,
    bool? isAvailable,
    String? messageSuccess,
  }) {
    return ProductsState(
      products: products ?? this.products,
      messageError: messageError ?? this.messageError,
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      isAvailable: isAvailable ?? this.isAvailable,
      messageSuccess: messageSuccess ?? this.messageSuccess,
    );
  }

  @override
  List<Object> get props => [
    products,
    messageError,
    isLoading,
    product,
    isAvailable,
    messageSuccess,
  ];
}

final class ProductsInitial extends ProductsState {}
