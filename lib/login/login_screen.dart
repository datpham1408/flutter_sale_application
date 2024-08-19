import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sale_application/entity/user_entity.dart';
import 'package:flutter_sale_application/login/login_cubit.dart';
import 'package:flutter_sale_application/login/login_state.dart';
import 'package:flutter_sale_application/main.dart';
import 'package:flutter_sale_application/model/user_model.dart';
import 'package:flutter_sale_application/resources/images.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController textEditingControllerEmail =
      TextEditingController();
  final TextEditingController textEditingControllerPassword =
      TextEditingController();
  final LoginCubit _loginCubit = getIt.get<LoginCubit>();
  bool isRememberLogin = false;
  CollectionReference? collectionReference;
  List<String> list = [];
  UserModel? entity;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loginCubit.checkRememberMe();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
          body: SafeArea(
        child: BlocProvider<LoginCubit>(
          create: (_) => _loginCubit,
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (_, LoginState state) {
              _handleListener(state);
            },
            builder: (_, LoginState state) {
              return itemBody();
            },
          ),
        ),
      )),
    );
  }

  Future<void> getUser({String? passText, String? emailText}) async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('user').get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> listData =
          querySnapshot.docs;

      for (int i = 0; i < listData.length; i++) {
        Map<String, dynamic> data = listData[i].data();
        String documentId = listData[i].id;

        String password = data['password'];
        String age = data['age'];
        String userName = data['user_name'];
        String phone = data['phone'];
        String role = data['role'];
        String idUser = data['id'];

        var userModel = UserModel(
            userName: userName,
            phone: phone,
            password: password,
            age: age,
            role: role,
            id: documentId,
            idUser: idUser);

        if (password == passText && documentId == emailText) {
          Utils.instance.showToast(thanhCong);
          handleItemClickHome1(userModel: userModel);
          break;
        } else {
          Utils.instance.showToast('That bai');
        }
      }
      //
      // for (var doc in querySnapshot.docs) {
      //
      // }
    } catch (error) {
      print('Lỗi khi lấy dữ liệu người dùng: $error');
    }
  }

  Widget itemBody() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          itemDetailBody(
              text: email, textEditingController: textEditingControllerEmail),
          Utils.instance.sizeBoxHeight(16),
          itemDetailBody(
              text: pass,
              textEditingController: textEditingControllerPassword,
              obscureText: true),
          GestureDetector(
              onTap: () {
                handleItemClickRegister();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(registerAccount),
              )),
          Utils.instance.sizeBoxHeight(16),
          BlocBuilder<LoginCubit, LoginState>(buildWhen: (_, LoginState state) {
            return state is CheckBoxState;
          }, builder: (_, LoginState state) {
            if (state is CheckBoxState) {
              return itemCheckBox(state: state);
            }
            return itemCheckBox();
          }),
          Utils.instance.sizeBoxHeight(16),
          itemButton(),
          Utils.instance.sizeBoxHeight(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              itemImages(facebook, () {}),
              Utils.instance.sizeBoxWidth(48),
              itemImages(google, () {
                _loginCubit.signGoogle();
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget itemImages(String image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(image),
    );
  }

  void handleItemClickRegister() {
    GoRouter.of(context).pushNamed(
      routerNameRegister,
    );
  }

  Widget itemDetailBody(
      {String text = '',
      TextEditingController? textEditingController,
      bool? obscureText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Utils.instance.sizeBoxHeight(4),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(36)),
          child: TextField(
            obscureText: obscureText ?? false,
            controller: textEditingController,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        )
      ],
    );
  }

  Widget itemButton() {
    return ElevatedButton(
      onPressed: () {
        // _loginCubit.checkedLogin(
        //   email: textEditingControllerEmail.text,
        //   password: textEditingControllerPassword.text,
        //   rememberMe: isRememberLogin,
        // );
        getUser(
            passText: textEditingControllerPassword.text,
            emailText: textEditingControllerEmail.text);
      },
      child: const Text(login),
    );
  }

  Widget itemCheckBox({CheckBoxState? state}) {
    return Row(
      children: [
        Checkbox(
            tristate: true,
            value: state?.isSelected ?? false,
            onChanged: (bool? value) {
              isRememberLogin = value ?? false;
              _loginCubit.checkBox(value);
            }),
        const Text(ghiNhoDangNhap),
      ],
    );
  }

  void _handleListener(LoginState state) {
    if (state is LoginCheckIsEmptyEmail) {
      Utils.instance.showToast(emailEmpty);
      return;
    }
    if (state is LoginCheckIsEmptyPassword) {
      Utils.instance.showToast(passwordEmpty);
      return;
    }
    if (state is ValidateEmailState) {
      Utils.instance.showToast(emailValidate);
      return;
    }
    if (state is ValidatePasswordState) {
      Utils.instance.showToast(passValidate);
      return;
    }
    if (state is LoginSuccessState) {
      entity = state.userModel;
      Utils.instance.showToast(thanhCong);
      handleItemClickHome1(userModel: entity);
      return;
    }
    if (state is LoginErrorState) {
      Utils.instance.showToast(userEmpty);
      return;
    }
    if (state is Authenticated) {
      handleItemClickHome1(userModel: entity);
      return;
    }
  }

  void handleItemClickHome1({UserModel? userModel}) {
    GoRouter.of(context).goNamed(
      routerNameHome,
      extra: {'userModel': userModel},
    );
  }

  void handleGoName() {
    GoRouter.of(context).goNamed(routerNameHome);
  }
}
