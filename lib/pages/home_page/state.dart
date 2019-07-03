import 'package:fish_redux/fish_redux.dart';

class HomeState implements Cloneable<HomeState> {
  int count = 0;

  @override
  HomeState clone() {
    return HomeState()..count = count;
  }
}

HomeState initState(Map<String, dynamic> args){
  //什么也没做，只是初始化数据
  return HomeState();
}