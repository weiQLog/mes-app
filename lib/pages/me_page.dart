import 'package:flutter/material.dart';
import 'package:flutter_template_plus/http/dao/login_dao.dart';
import 'package:flutter_template_plus/navigator/my_navigator.dart';
import 'package:flutter_template_plus/navigator/my_navigator_util.dart';
import 'package:flutter_template_plus/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          left: 35,
          right: 35,
        ),
        children: [
          OutlinedButton(
            child: Text("亮色模式"),
            onPressed: () {
              context.read<ThemeProvider>().setThemeMode(ThemeMode.light);
            },
          ),
          OutlinedButton(
            child: Text("黑暗模式"),
            onPressed: () {
              context.read<ThemeProvider>().setThemeMode(ThemeMode.dark);
            },
          ),
          OutlinedButton(
            child: Text("跟随系统"),
            onPressed: () {
              context.read<ThemeProvider>().setThemeMode(ThemeMode.system);
            },
          ),
          ElevatedButton(
            child: Text("退出登录"),
            onPressed: () {
              LoginDao.removeToken();
              MyNavigator.getInstance().onJumpTo(RouteStatus.login);
            },
          ),
        ],
      ),
    );
  }
}
