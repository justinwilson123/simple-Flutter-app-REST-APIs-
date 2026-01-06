import 'package:restapiproduct/feature/products/domain/entity/product_entity.dart';

class ProductsModel extends ProductEntity {
  const ProductsModel({
    required super.id,
    required super.name,
    super.price,
    super.isAvailable,
  });
  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json["product_id"],
      name: json["product_name"],
      price: json["product_price"],
      isAvailable: json["is_available"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": price.toString(),
      "is_available": isAvailable.toString(),
    };
  }
}
