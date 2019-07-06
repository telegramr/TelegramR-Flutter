import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'effect.dart';
import 'view.dart';
import 'reducer.dart';

class ChatPage extends Page<ChatState, Map<String, dynamic>> {
  ChatPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          // dependencies: Dependencies<HomePageState>(
          //     adapter: MovieGroupAdapter(),
          //     slots: <String, Dependent<HomePageState>>{}),
        );
}
