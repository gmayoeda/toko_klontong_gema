part of 'product_bloc.dart';

sealed class ProductEvent {}

class GetProductEvent extends ProductEvent {}

class SearchProductEvent extends ProductEvent {
  final String itemName;
  SearchProductEvent(this.itemName);
}

class CreateProductEvent extends ProductEvent {
  final CreateProduct data;
  CreateProductEvent({required this.data});
}

class UpdateProductEvent extends ProductEvent {
  final String id;
  UpdateProductEvent({required this.id});
}

class DeleteProductEvent extends ProductEvent {
  final String id;
  DeleteProductEvent({required this.id});
}
