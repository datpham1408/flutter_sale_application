import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/entity/user_entity.dart';
import 'package:flutter_sale_application/register/register_state.dart';
import 'package:flutter_sale_application/resources/hive_key.dart';
import 'package:hive/hive.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState());

  void checkEmpty(
      {String email = '',
      String yourName = '',
      String password = '',
      String confirmPassword = '',
      String phone = '',
      String age = ''}) {
    if (email.isEmpty) {
      emit(RegisterCheckIsEmptyEmail());
      return;
    }
    if (yourName.isEmpty) {
      emit(RegisterCheckIsEmptyYourName());
      return;
    }
    if (age.isEmpty) {
      emit(RegisterCheckIsEmptyAge());
      return;
    }
    if (phone.isEmpty) {
      emit(RegisterCheckIsEmptyPhone());
      return;
    }
    if (password.isEmpty) {
      emit(RegisterCheckIsEmptyPassword());
      return;
    }
    if (confirmPassword.isEmpty) {
      emit(RegisterCheckIsEmptyConfirmPassword());
      return;
    }
  }

  void checkedAllTextFlied(
      {String email = '',
      String password = '',
      String confirmPassword = '',
      String yourName = '',
      String phone = '',
      String age = ''}) {
    final bool isEmail = EmailValidator.validate(email);
    final bool isPassword = password.length > 6 && password.length < 12;
    final bool isConfirmPassword =
        confirmPassword.length > 6 && confirmPassword.length < 12;
    final bool isYourName = yourName.length >= 8;
    final bool isPhone = phone.length >= 10 && phone.length < 11;

    if (!isEmail) {
      emit(ValidateEmailState());
      return;
    }
    if (!isYourName) {
      emit(ValidateYourNameState());
      return;
    }
    if (!isPhone) {
      emit(ValidatePhoneState());
      return;
    }

    if (!isPassword) {
      emit(ValidatePasswordState());
      return;
    }
    if (!isConfirmPassword) {
      emit(ValidateConfirmPasswordState());
      return;
    }

    if (password != confirmPassword) {
      emit(CheckValidateConfirmPasswordStateIsTheSamePassword());
      return;
    }

    emit(ValidateSuccessState(
        email: email,
        pass: password,
        confirmPassword: confirmPassword,
        yourName: yourName,
        phone: phone,
        age: age));
  }

  Future<void> saveLoginInfo(
      {String email = '',
      String password = '',
      String age = '',
      String phone = '',
      String fullName = '',
      String selected = ''}) async {
    final box = await Hive.openBox<UserEntity>(HiveKey.user);

    final user = UserEntity()
      ..email = email
      ..phone = phone
      ..password = password
      ..age = age
      ..fullName = fullName
      ..selected = selected;

    await box.add(user);
    var a = 0;
  }

  void checkBox(bool? value) {
    emit(CheckBoxState(isSelected: value));
  }

  void checkBox1(bool? value) {
    emit(CheckBoxState1(isSelected: value));
  }
}
