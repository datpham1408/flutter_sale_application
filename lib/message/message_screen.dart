import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_sale_application/entity/user_entity.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:go_router/go_router.dart';

import '../model/user_model.dart';

class MessageScreen extends StatefulWidget {
  final UserModel? entity;

  MessageScreen({super.key, required this.entity});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  bool isSplashEnabled = false;
  String value = 'Khong';

  @override
  void initState() {
    super.initState();
    // setupRemoteConfig();
    setUpRemote();
  }

  Future<void> setupRemoteConfig() async {
    final defaults = <String, dynamic>{
      'splash': false,
    };
    await _remoteConfig.setDefaults(defaults);

    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print('Lỗi khi lấy cấu hình từ xa: $e');
    }

    setState(() {
      isSplashEnabled = _remoteConfig.getBool('splash');
    });
  }

  Future<void> setUpRemote() async {
    _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 15),
        minimumFetchInterval: Duration(seconds: 15)));
    try {
      await _remoteConfig.fetchAndActivate();
      var data = _remoteConfig.getAll();
    } catch (e) {
      print('loi :$e');
    }
    setState(() {
      value = _remoteConfig.getString(welcome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Config Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Date status : $value'),
            const SizedBox(height: 20),
            Utils.instance.sizeBoxHeight(20),
            ElevatedButton(
              onPressed: () {
                handleClickChat(widget.entity);
              },
              child: const Text('Chat'),
            ),
            ElevatedButton(
              onPressed: () {
                handleClickChatGroup(widget.entity);
              },
              child: const Text('Chat Group'),
            ),
          ],
        ),
      ),
    );
  }

  void handleClickChat(UserModel? entity) {
    GoRouter.of(context).pushNamed(
      routerNameChat,
      extra: {'entity': entity},
    );
  }
  void handleClickChatGroup(UserModel? entity) {
    GoRouter.of(context).pushNamed(
      routerNameChatGroup,
      extra: {'entity': entity},
    );
  }

  Future<void> toggleSplashStatus(bool enabled) async {
    await _remoteConfig.setDefaults({'splash': enabled});
    await _remoteConfig.fetchAndActivate();
    setState(() {
      isSplashEnabled = enabled;
    });
  }

  Future<void> datStatus(String data) async {
    await _remoteConfig.setDefaults({'Dat': data});
    await _remoteConfig.fetchAndActivate();
    setState(() {
      value = data;
    });
  }
}
