import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'action.dart';

Reducer<HomeState> buildReducer() {
  return asReducer<HomeState>(<Object, Reducer<HomeState>>{
    CounterAction.add: _add,
  });
}

HomeState _add(HomeState state, Action action) {
  final HomeState newState = state.clone();
  newState.count = ++state.count;
  return newState;
}

HomeState _goPage2(HomeState state, Action action) {
  // final HomeState newState = state.clone();
  // newState.count = ++state.count;
  // return newState;
}