import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/home/sale_application_cubit.dart';
import 'package:flutter_sale_application/home/sale_application_state.dart';
import 'package:flutter_sale_application/main.dart';

class SaleApplicationHomeScreen extends StatefulWidget {
  const SaleApplicationHomeScreen({super.key});

  @override
  State<SaleApplicationHomeScreen> createState() =>
      _SaleApplicationHomeScreenState();
}

class _SaleApplicationHomeScreenState extends State<SaleApplicationHomeScreen> {
  final SaleApplicationCubit _saleApplicationCubit =
      getIt.get<SaleApplicationCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider<SaleApplicationCubit>(
        create: (_) => _saleApplicationCubit,
        child: BlocConsumer<SaleApplicationCubit, SaleApplicationState>(
          listener: (_, SaleApplicationState state) {
            _handleListener(state);
          },
          builder: (_, SaleApplicationState state) {
            return itemBody();
          },
        ),
      ),
    ));
  }

  Widget itemBody() {
    return Container();
  }

  void _handleListener(SaleApplicationState state) {}
}
