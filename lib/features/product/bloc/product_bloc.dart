import 'package:bloc/bloc.dart';
import 'package:toko_klontong_gema/features/product/domain/models/create_product_model.dart';
import 'package:toko_klontong_gema/features/product/domain/models/product_crud_model.dart';
import 'package:toko_klontong_gema/features/product/domain/services/product_services.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    ProductService service = ProductService();
    List<ProductCrudModel> listProduct = [];

    on<GetProductEvent>((event, emit) async {
      try {
        emit(ProductLoading());
        await service.requestProduct().then((resResult) async {
          listProduct = resResult;
          emit(ProductGetSucess(listProduct));
        });
      } catch (e) {
        emit(ProductFailed(e.toString()));
      }
    });

    on<SearchProductEvent>((event, emit) async {
      try {
        emit(ProductLoading());
        final filteredItems = listProduct
            .where((item) => item.name!.toLowerCase().contains(event.itemName))
            .toList();

        emit(ProductGetSucess(filteredItems));
      } catch (e) {
        emit(ProductFailed(e.toString()));
      }
    });
  }
}
