import 'package:flutter/material.dart';
import 'package:flutter_template_plus/navigator/my_navigator_util.dart';
import 'package:flutter_template_plus/pages/navigator_page.dart';

/// 监听路由页面跳转，感知当前页面是否压后台
class MyNavigator extends AbstractRouteJumpListener {
  static MyNavigator? _instance;

  RouteJumpListener? _routeJump;
  List<RouteChangeListener> _listeners = [];
  RouteStatusInfo? _current;

  // 导航页底部 tab
  RouteStatusInfo? _bottomTab;

  MyNavigator._();

  // 单例模式
  static MyNavigator getInstance() {
    if (_instance == null) {
      _instance = MyNavigator._();
    }
    return _instance!;
  }

  // 导航页底部 tab 切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.navigator, page);
    _notify(_bottomTab!);
  }

  // 注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }

  // 监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    // 如果没有添加过则添加进去
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  // 移除监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  // 切换路由
  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJump?.onJumpTo(routeStatus, args: args);
  }

  // 通知路由页面变化，currentPages 当前页面堆栈，prePages 变化前的页面堆栈
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    // 如果没有变化，则不做处理，直接 return
    if (currentPages == prePages) return;
    var current = RouteStatusInfo(
      getStatus(currentPages.last),
      currentPages.last.child,
    );
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is NavigatorPage && _bottomTab != null) {
      // 如果打开的是导航页，则明确到导航页具体的 tab
      current = _bottomTab!;
    }
    print('my_navigator:当前页面:${current.page}');
    print('my_navigator:上一个页面:${_current?.page}');
    _listeners.forEach((listener) {
      listener(current, _current);
    });
    _current = current;
  }
}
