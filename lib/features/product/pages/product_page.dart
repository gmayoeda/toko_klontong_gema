import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:toko_klontong_gema/features/product/bloc/product_bloc.dart';
import 'package:toko_klontong_gema/features/product/pages/items/product_card.dart';
import 'package:toko_klontong_gema/utils/commons/alert/custom_alerts.dart';
import 'package:toko_klontong_gema/utils/config/routes/route_manager.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductInitial) {
            SmartDialog.dismiss();
          }
          if (state is ProductLoading) {
            SmartDialog.showLoading();
          }
          if (state is ProductUpdateSucess) {
            SmartDialog.dismiss();
            displaySnackBar(context,
                message: 'Product update successful!', success: true);
          }
          if (state is ProductDeleteSucess) {
            SmartDialog.dismiss();
            displaySnackBar(context,
                message: 'Product delete successful!', success: true);
          }
          if (state is ProductFailed) {
            SmartDialog.dismiss();
            displaySnackBar(context, message: state.e, success: false);
          }
        },
        builder: (context, state) {
          if (state is ProductGetSucess) {
            SmartDialog.dismiss();
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.result.length,
                      (BuildContext context, int index) {
                        final data = state.result[index];
                        return ProductCard(
                          image: data.image!,
                          categoryName: data.categoryName!,
                          productName: data.name!,
                          price: data.harga!,
                          press: () {
                            Navigator.pushNamed(
                                context, RouteManager.productDetails,
                                arguments: data);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
