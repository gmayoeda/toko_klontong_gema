part of 'product_bloc.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductGetSucess extends ProductState {
  final List<ProductCrudModel> result;
  ProductGetSucess({required this.result});
}

final class ProductCreatedSucess extends ProductState {}

final class ProductUpdateSucess extends ProductState {}

final class ProductDeleteSucess extends ProductState {}

final class ProductFailed extends ProductState {
  final String e;
  ProductFailed(this.e);
}
