import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:toko_klontong_gema/features/product/bloc/product_bloc.dart';
import 'package:toko_klontong_gema/features/product/domain/models/create_product_model.dart';
import 'package:toko_klontong_gema/utils/commons/alert/custom_alerts.dart';
import 'package:toko_klontong_gema/utils/commons/button/custom_button_primary.dart';
import 'package:toko_klontong_gema/utils/commons/form/dynamic_textfield.dart';
import 'package:toko_klontong_gema/utils/commons/helper/methods.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController categoryId = TextEditingController();
  TextEditingController categoryName = TextEditingController();
  TextEditingController sku = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController width = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController harga = TextEditingController();

  @override
  void dispose() {
    id.dispose();
    categoryId.dispose();
    categoryName.dispose();
    sku.dispose();
    name.dispose();
    description.dispose();
    weight.dispose();
    width.dispose();
    length.dispose();
    height.dispose();
    image.dispose();
    harga.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        actions: const [],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) async {
          if (state is ProductCreatedSucess) {
            SmartDialog.dismiss();
            context.read<ProductBloc>().add(GetProductEvent());
            Navigator.pop(context);
          }
          if (state is ProductFailed) {
            SmartDialog.dismiss();
            displaySnackBar(context, message: state.e, success: false);
          }
        },
        builder: (context, state) {
          if (state is ProductLoading) {
            SmartDialog.showLoading();
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      title: "ID",
                      controller: id,
                      isNumber: true,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: CustomTextField(
                            title: "Category ID",
                            controller: categoryId,
                            isNumber: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            title: "Category Name",
                            controller: categoryName,
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      title: "SKU",
                      controller: sku,
                    ),
                    CustomTextField(
                      title: "Name",
                      controller: name,
                    ),
                    CustomTextField(
                      title: "Description",
                      controller: description,
                      minLines: 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            title: "Weight",
                            controller: weight,
                            isNumber: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            title: "Length",
                            controller: length,
                            isNumber: true,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            title: "Height",
                            controller: height,
                            isNumber: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            title: "Width",
                            controller: width,
                            isNumber: true,
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      title: "Price",
                      controller: harga,
                      isCurrency: true,
                    ),
                    CustomTextField(
                      title: "URL Image",
                      controller: image,
                      minLines: 2,
                    ),
                    const SizedBox(height: 30),
                    ButtonPrimary(
                      title: 'Add Product',
                      action: () {
                        final form = formkey.currentState;
                        if (form!.validate()) {
                          form.save();

                          CreateProduct submitData = CreateProduct(
                            id: int.parse(id.text),
                            categoryId: int.parse(categoryId.text),
                            categoryName: categoryName.text,
                            sku: sku.text,
                            name: name.text,
                            description: description.text,
                            weight: int.parse(weight.text),
                            width: int.parse(width.text),
                            length: int.parse(length.text),
                            height: int.parse(height.text),
                            image: image.text,
                            harga: int.parse(harga.text.clearNom()),
                          );

                          final read = context.read<ProductBloc>();
                          read.add(CreateProductEvent(data: submitData));
                        }
                      },
                      icon: const Icon(
                        Icons.add_box,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
