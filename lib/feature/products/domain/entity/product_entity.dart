import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int? id;
  final String name;
  final int? price;
  final bool? isAvailable;

  const ProductEntity({
    this.id,
    required this.name,
    this.price,
    this.isAvailable,
  });
  @override
  List<Object?> get props => [id, name, price, isAvailable];
}
