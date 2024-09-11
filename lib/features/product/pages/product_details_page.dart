import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toko_klontong_gema/features/product/bloc/product_bloc.dart';
import 'package:toko_klontong_gema/features/product/domain/models/product_crud_model.dart';
import 'package:toko_klontong_gema/features/product/pages/items/cart_button.dart';
import 'package:toko_klontong_gema/features/product/pages/items/product_availability_tag.dart';
import 'package:toko_klontong_gema/utils/config/theme/themes.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.data});
  final ProductCrudModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CartButton(
        price: data.harga!,
        press: () {},
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.40,
                          width: MediaQuery.sizeOf(context).width,
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: CachedNetworkImage(
                                imageUrl: data.image!,
                                fit: BoxFit.fill,
                              )),
                        ),
                        const SizedBox(height: 20.0),
                        Text(data.name!.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        Text(data.categoryName!,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 16)),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            const ProductAvailabilityTag(),
                            const Spacer(),
                            SvgPicture.asset("assets/icons/Star_filled.svg"),
                            const SizedBox(width: 16 / 4),
                            Text(
                              "4.3 ",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const Text("(167 Reviews)"),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        const Text("Product Info",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        const SizedBox(height: 8.0),
                        Text(
                            "${data.description!}asdasd asdasdasdsa asdasdasda dasdasdasdsa dasd asdasdasd asdasdasda asdas",
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.normal,
                                fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: mainColors,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
