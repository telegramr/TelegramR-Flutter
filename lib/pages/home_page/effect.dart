import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

import 'state.dart';
import 'action.dart';

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    CounterAction.onAdd: _onAdd,
    CounterAction.goToPage2: _NavigateToPage2
  });
}

void _onAdd(Action action, Context<HomeState> ctx) {
  print("effect _onAdd+++++");
  ctx.dispatch(CounterActionCreator.add());
}

void _NavigateToPage2(Action action, Context<HomeState> ctx) {
  print("_NavigateToPage2");
  Navigator.of(ctx.context).pushNamed('counter_fish_redux2');
  // ctx.dispatch(CounterActionCreator.add());
}

// void _onEdit(Action action, Context<PageState> ctx) {
//   print('Effect _onEdit');
//   showDialog(
//       context: ctx.context,
//       builder: (_) => new AlertDialog(
//           title: Text("Modify content"),
//           content: TextField(
//             onChanged: (_){
//               _input = _;
//             },
//           ),
//           actions:<Widget>[
//             new FlatButton(child:new Text("CANCEL"), onPressed: (){
//               Navigator.of(ctx.context).pop();
//             },),
//             new FlatButton(child:new Text("OK"), onPressed: (){
//               Navigator.of(ctx.context).pop<String>(_input);  //确定按钮关闭对话框携带数据
//             },)
//           ]
//       )
//   ).then((_){  //数据回传后通过updateAction更新页面数据
//     ctx.dispatch(PageActionCreator.updateAction('title', _));
//   });
// }