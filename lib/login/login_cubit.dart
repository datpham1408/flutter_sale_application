import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/login/login_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  final auth = FirebaseAuth.instance;

  void checkEmpty({
    String email = '',
    String password = '',
  }) {
    if (email.isEmpty) {
      emit(LoginCheckIsEmptyEmail());
      return;
    }
    if (password.isEmpty) {
      emit(LoginCheckIsEmptyPassword());

      return;
    }
  }

  Future<void> signGoogle() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser?.authentication;

    if (googleAuth != null) {
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        emit(LoginWithGoogleSuccessState(user: user));
      } else {
        emit(LoginWithGoogleErrorState());
      }

      // user.user?.
    }
  }

  void checkedAllTextFlied({
    String email = '',
    String password = '',
  }) {
    final bool isEmail = EmailValidator.validate(email);
    final bool isPassword = password.length > 6 && password.length < 12;

    if (!isEmail) {
      emit(ValidateEmailState());
      return;
    }
    if (!isPassword) {
      emit(ValidatePasswordState());
      return;
    }
  }

  Future<void> checkedLogin({
    required String email,
    required String password,
    bool? rememberMe = false,
  }) async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('user').get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      String documentId = doc.id;

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

      if (documentId.isNotEmpty && password.isNotEmpty) {
        if (documentId == email && password == password) {
          if (rememberMe == true) {
            await saveRememberMe(email, password);
          }
          emit(LoginSuccessState(userModel: userModel));
        }
      } else {
        emit(LoginErrorState());
      }
    }
  }

  Future<void> checkRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool('rememberMe') ?? false;
    String email = prefs.getString('email') ?? '';
    String password = prefs.getString('password') ?? '';

    if (rememberMe) {
      await checkedLogin(
        email: email,
        password: password,
        rememberMe: true,
      );
      emit(Authenticated());
    }
  }

  Future<void> saveRememberMe(String email, String pass) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', true);
    await prefs.setString('email', email);
    await prefs.setString('password', pass);
  }

  void checkBox(bool? value) {
    emit(CheckBoxState(isSelected: value));
  }
}
