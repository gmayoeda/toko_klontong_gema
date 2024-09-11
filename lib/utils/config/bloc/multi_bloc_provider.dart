import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toko_klontong_gema/features/auth/bloc/auth_bloc.dart';
import 'package:toko_klontong_gema/features/product/bloc/product_bloc.dart';

class MultiBlocProviders extends StatelessWidget {
  final Widget child;
  const MultiBlocProviders({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AuthBloc()),
      BlocProvider(create: (context) => ProductBloc()..add(GetProductEvent())),
    ], child: child);
  }
}
