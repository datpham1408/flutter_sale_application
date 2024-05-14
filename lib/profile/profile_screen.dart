import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/main.dart';
import 'package:flutter_sale_application/profile/profile_cubit.dart';
import 'package:flutter_sale_application/profile/profile_state.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  final User? user;

  ProfileScreen({super.key, this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileCubit _profileCubit = getIt.get<ProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider<ProfileCubit>(
        create: (_) => _profileCubit,
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (_, ProfileState state) {
            _handleListener(state);
          },
          builder: (_, ProfileState state) {
            return itemBody();
          },
        ),
      ),
    ));
  }

  Widget itemBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [itemButton()],
    );
  }

  Widget itemButton() {
    return GestureDetector(
      onTap: () {
        _profileCubit.logout();
      },
      child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.grey),
          child: const Text(dangXuat)),
    );
  }

  void _handleListener(ProfileState state) {
    if (state is LogoutState) {
      handleItemClickLogout();
    }
  }

  void handleItemClickLogout() {
    GoRouter.of(context).pushNamed(
      routerNameLogin,
    );
  }
}
