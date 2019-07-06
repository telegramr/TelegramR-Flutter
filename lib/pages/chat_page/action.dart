import 'package:fish_redux/fish_redux.dart';
import 'package:telegramr/models/message_model.dart';
import 'package:telegramr/models/sticker.dart';

enum ChatAction {
  add, 
  onAdd,
  didLoad,
  onFetch,
  onTextInput,
  addMessage,
  sendMessage,
  handleSendMessage,
  onAddMessage,
  setMenuName,
  onSetMenuName,
  onFocus,
  backPress,
  onBackPress,
  didBackPress,
  sendOtherMessage,
  handleSendOtherMessage,
  getImage,
  handleGetImage,
  handleSendSticker
}

class ChatActionCreator {
  /// 交互action
  // reducer使用
  static Action add() {
    return const Action(ChatAction.add);
  }
  // effect使用
  static Action onAdd() {
    return const Action(ChatAction.onAdd);
  }

  static Action addMessage() {
    return const Action(ChatAction.addMessage);
  }

   static Action onAddMessage(List messages) {
    return Action(ChatAction.onAddMessage, payload: messages);
  }

  static Action didLoadAction(List messages) {
    return Action(ChatAction.didLoad, payload: messages);
  }

   static Action onFetchAction() {
    return Action(ChatAction.onFetch);
  }

   static Action onTextFieldChanged(String text) {
    return Action(ChatAction.onTextInput, payload: text.trim() == '' ? '' : text);
  }

  static Action handleSendMessage() {
    return Action(ChatAction.handleSendMessage);    
  }

  static Action sendMessage(String text) {
     if(text.trim() != '') {
      // textEditingController.clear();
        var newMessage = {
          "id": 1,
          "from_id": 1,
          "to_id": 2,
          "out": true,
          "uname": "Beats0",
          "avatar": "https://avatars0.githubusercontent.com/u/29087203?s=460&v=4",
          "message": {"text": text},
          "date": 1559377920312,
          "type": "text"
      };
      return Action(ChatAction.sendMessage, payload: MessageT.fromJson(newMessage));
     }
  }

  static Action handleSendSticker(StickerItemT sticker) {
    var newMessage = {
      "id": 1,
      "from_id": 1,
      "to_id": 2,
      "out": true,
      "uname": "Beats0",
      "avatar": "https://avatars0.githubusercontent.com/u/29087203?s=460&v=4",
       "message": {
        "sticker": sticker.toJson()
      },
      "date": 1559377920312,
      "type": "sticker"
    };
    return Action(ChatAction.sendOtherMessage, payload: MessageT.fromJson(newMessage));
  }

  static Action handleGetImage() {
    return Action(ChatAction.getImage);
  }

  static Action handleSendOtherMessage(Map newMessage) {
      return Action(ChatAction.sendOtherMessage, payload: MessageT.fromJson(newMessage));
  }

  static Action setMenuName(String menuName) {
    return Action(ChatAction.onSetMenuName, payload: menuName);
  }

  static Action onFocus() {
    return Action(ChatAction.onFocus);
  }

  static Action backPress() {
    return Action(ChatAction.onBackPress);
  }

  static Action onBackPress() {
    return Action(ChatAction.onBackPress);
  }

  static Action didBackPress() {
    return Action(ChatAction.didBackPress);
  }
}