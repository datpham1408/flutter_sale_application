import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sale_application/register/register_cubit.dart';
import 'package:flutter_sale_application/register/register_state.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _textEditingControllerEmail =
      TextEditingController();
  final TextEditingController _textEditingControllerName =
      TextEditingController();
  final TextEditingController _textEditingControllerAge =
      TextEditingController();
  final TextEditingController _textEditingControllerPass =
      TextEditingController();
  final TextEditingController _textEditingControllerConfirmPass =
      TextEditingController();
  final TextEditingController _textEditingControllerPhone =
      TextEditingController();
  final RegisterCubit _registerCubit = getIt.get<RegisterCubit>();
  bool isCheck = false;
  bool isCheck1 = false;
  String value = '';

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
          body: SafeArea(
        child: BlocProvider<RegisterCubit>(
          create: (_) => _registerCubit,
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (_, RegisterState state) {
              _handleListener(state);
            },
            builder: (_, RegisterState state) {
              return SingleChildScrollView(child: itemBody());
            },
          ),
        ),
      )),
    );
  }

  Widget itemBody() {
    return Container(
      color: Colors.lightBlueAccent,
      child: Column(
        children: [
          const Text(
            dangKi,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          itemTextFlied(
              text: email, textEditingController: _textEditingControllerEmail),
          itemTextFlied(
              text: fullName,
              textEditingController: _textEditingControllerName),
          itemTextFlied(
              text: age, textEditingController: _textEditingControllerAge),
          itemTextFlied(
              text: phone, textEditingController: _textEditingControllerPhone),
          itemTextFlied(
              text: pass,
              textEditingController: _textEditingControllerPass,
              obscureText: true),
          itemTextFlied(
              text: confirmPass,
              textEditingController: _textEditingControllerConfirmPass,
              obscureText: true),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                BlocBuilder<RegisterCubit, RegisterState>(
                    buildWhen: (_, RegisterState state) {
                  return state is CheckBoxState;
                }, builder: (_, RegisterState state) {
                  if (state is CheckBoxState) {
                    return itemCheckBox(state: state, text: user);
                  }
                  return itemCheckBox(text: user);
                }),
                BlocBuilder<RegisterCubit, RegisterState>(
                    buildWhen: (_, RegisterState state) {
                  return state is CheckBoxState1;
                }, builder: (_, RegisterState state) {
                  if (state is CheckBoxState1) {
                    return itemCheckBox1(state: state, text: store);
                  }
                  return itemCheckBox1(text: store);
                }),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                handleItemClickLogin();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(alreadyAccount),
              )),
          itemButton(),
        ],
      ),
    );
  }

  void handleItemClickLogin() {
    GoRouter.of(context).pushNamed(
      routerNameLogin,
    );
  }

  Widget itemButton() {
    return ElevatedButton(
      onPressed: () {
        _registerCubit.checkEmpty(
            email: _textEditingControllerEmail.text,
            yourName: _textEditingControllerName.text,
            password: _textEditingControllerPass.text,
            confirmPassword: _textEditingControllerConfirmPass.text,
            phone: _textEditingControllerPhone.text,
            age: _textEditingControllerAge.text);
        _registerCubit.checkedAllTextFlied(
            email: _textEditingControllerEmail.text,
            yourName: _textEditingControllerName.text,
            password: _textEditingControllerPass.text,
            confirmPassword: _textEditingControllerConfirmPass.text,
            phone: _textEditingControllerPhone.text,
            age: _textEditingControllerAge.text);
      },
      child: const Text(
        registerAccount,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget itemCheckBox({CheckBoxState? state, String? text}) {
    return Row(
      children: [
        Checkbox(
            tristate: true,
            value: state?.isSelected ?? false,
            onChanged: (bool? value) {
              isCheck = value ?? false;
              _registerCubit.checkBox(value);
            }),
        Text(text ?? ''),
      ],
    );
  }

  Widget itemCheckBox1({CheckBoxState1? state, String? text}) {
    return Row(
      children: [
        Checkbox(
            tristate: true,
            value: state?.isSelected ?? false,
            onChanged: (bool? value) {
              isCheck1 = value ?? false;
              _registerCubit.checkBox1(value);
            }),
        Text(text ?? ''),
      ],
    );
  }

  Widget itemTextFlied(
      {String text = '',
      TextEditingController? textEditingController,
      bool? obscureText}) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Utils.instance.sizeBoxHeight(4),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(36)),
            child: TextField(
              obscureText: obscureText ?? false,
              controller: textEditingController,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }


  void _handleListener(RegisterState state) {
    if (state is RegisterCheckIsEmptyEmail) {
      Utils.instance.showToast(emailEmpty);
      return;
    }
    if (state is RegisterCheckIsEmptyYourName) {
      Utils.instance.showToast(fullNameEmpty);
      return;
    }
    if (state is RegisterCheckIsEmptyPassword) {
      Utils.instance.showToast(passwordEmpty);
      return;
    }
    if (state is RegisterCheckIsEmptyConfirmPassword) {
      Utils.instance.showToast(confirmEmpty);
      return;
    }
    if (state is RegisterCheckIsEmptyPhone) {
      Utils.instance.showToast(phoneEmpty);
      return;
    }
    if (state is RegisterCheckIsEmptyAge) {
      Utils.instance.showToast(ageEmpty);
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
    if (state is ValidateConfirmPasswordState) {
      Utils.instance.showToast(confirmValidate);
      return;
    }
    if (state is ValidatePhoneState) {
      Utils.instance.showToast(phoneValidate);
      return;
    }
    if (state is ValidateYourNameState) {
      Utils.instance.showToast(fullNameValidate);
      return;
    }
    if (state is CheckValidateConfirmPasswordStateIsTheSamePassword) {
      Utils.instance.showToast(passSameConfirm);
      return;
    }
    if (state is CheckBoxState) {
      if (state.isSelected == true) {
        value = user;
      }
    }
    if (state is CheckBoxState1) {
      if (state.isSelected == true) {
        value = store;
      }
    }
    if (state is ValidateSuccessState) {
      final String email = state.email;
      final String pass = state.pass;
      final String phone = state.phone;
      final String age = state.age;
      final String fullName = state.yourName;
      _registerCubit.saveLoginInfo(
          email: email,
          password: pass,
          phone: phone,
          age: age,
          fullName: fullName,
          selected: value);
      Utils.instance.showToast('Dang ki thanh cong');
      handleItemClickLogin();
    }
  }
}
