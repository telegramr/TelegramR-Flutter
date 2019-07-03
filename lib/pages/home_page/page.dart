import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'effect.dart';
import 'view.dart';
import 'reducer.dart';

class HomePage extends Page<HomeState, Map<String, dynamic>> {
  HomePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
        );
}
