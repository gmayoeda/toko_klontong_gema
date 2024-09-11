import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:toko_klontong_gema/features/product/bloc/product_bloc.dart';
import 'package:toko_klontong_gema/features/product/pages/items/product_card.dart';
import 'package:toko_klontong_gema/utils/commons/alert/custom_alerts.dart';
import 'package:toko_klontong_gema/utils/config/routes/route_manager.dart';
import 'package:toko_klontong_gema/utils/config/theme/themes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isSearch = false;
  TextEditingController keyword = TextEditingController();

  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> onRefresh() async {
    context.read<ProductBloc>().add(GetProductEvent());
  }

  Future<void> onSearch() async {
    context.read<ProductBloc>().add(SearchProductEvent(keyword.text));
  }

  @override
  void dispose() {
    keyword.dispose();
    super.dispose();
  }

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
            return Column(
              children: [
                _searchBar(),
                Expanded(
                  child: RefreshIndicator(
                    key: refreshKey,
                    onRefresh: onRefresh,
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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

  _searchBar() {
    return SizedBox(
      height: 72,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: TextFormField(
            controller: keyword,
            autovalidateMode: AutovalidateMode.disabled,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: mainColors, width: 1),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: mainColors, width: 1),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
              filled: true,
              fillColor: mainColors.withOpacity(0.05),
              prefixIcon: const Icon(Icons.production_quantity_limits),
              suffixIcon: IconButton(
                icon: isSearch
                    ? const Icon(Icons.clear)
                    : const Icon(Icons.search),
                onPressed: () {
                  if (isSearch) {
                    keyword.clear();
                    setState(() {
                      isSearch = false;
                    });
                    onSearch();
                  } else {
                    if (keyword.text.isNotEmpty) {
                      onSearch();
                      setState(() {
                        isSearch = true;
                      });
                    }
                  }
                },
              ),
              hintText: 'Search by name product',
            ),
          ),
        ),
      ),
    );
  }
}
