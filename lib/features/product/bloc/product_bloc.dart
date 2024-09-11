import 'package:bloc/bloc.dart';
import 'package:toko_klontong_gema/features/product/domain/models/create_product_model.dart';
import 'package:toko_klontong_gema/features/product/domain/models/product_crud_model.dart';
import 'package:toko_klontong_gema/features/product/domain/services/product_services.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    ProductService service = ProductService();
    on<GetProductEvent>((event, emit) async {
      try {
        emit(ProductLoading());
        await service.requestProduct().then((resResult) async {
          emit(ProductGetSucess(result: resResult));
        });
      } catch (e) {
        emit(ProductFailed(e.toString()));
      }
    });
  }
}
