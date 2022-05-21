// import 'dart:convert';

// import 'package:web_socket_channel/io.dart';

// class WsManager {
//   var userId = '';
//   var nickname = '';
//   var friends = []; // 好友id列表
//   var groups = []; // 群组id列表
//   var historyMessage = []; // 接收到的所有的历史消息
//   var messageList = []; // 所有消息页面人员
//   var currentMessageList = []; // 选择进入详情页的消息历史记录
//   var connecting = false; // websocket连接状态
//   IOWebSocketChannel channel = null;

//   createWebsocket() {
//     //创建连接并且发送鉴别身份信息
//     channel =
//         IOWebSocketChannel.connect(
//           'ws://101.42.134.18:10002/ws', 
//           headers: {});
//     var obj = {
//       "uid": uid,
//       "type": 1,
//       "nickname": nickname,
//       "msg": "",
//       "bridge": [],
//       "groupId": ""
//     };
//     String text = json.encode(obj).toString();
//     channel.sink.add(text);
//     //监听到服务器返回消息
//     channel.stream.listen((data) => listenMessage(data),
//         onError: onError, onDone: onDone);
//   }

//   listenMessage(data) {
//     connecting = true;
//     var obj = jsonDecode(data);
//     print(data);
//     if (obj['type'] == 1) {
//       // 获取聊天室的人员与群列表
//       messageList = [];
//       print(obj['msg']);
//       users = obj['users'];
//       groups = obj['groups'];
//       for (var i = 0; i < groups.length; i++) {
//         messageList.add(new Conversation(
//             avatar: 'assets/images/ic_group_chat.png',
//             title: groups[i]['name'],
//             des: '点击进入聊天',
//             updateAt: obj['date'].substring(11, 16),
//             unreadMsgCount: 0,
//             displayDot: false,
//             groupId: groups[i]['id'],
//             type: 2));
//       }
//       for (var i = 0; i < users.length; i++) {
//         if (users[i]['uid'] != uid) {
//           messageList.add(new Conversation(
//               avatar: 'assets/images/ic_group_chat.png',
//               title: users[i]['nickname'],
//               des: '点击进入聊天',
//               updateAt: obj['date'].substring(11, 16),
//               unreadMsgCount: 0,
//               displayDot: false,
//               userId: users[i]['uid'],
//               type: 1));
//         }
//       }
//     } else if (obj['type'] == 2) {
//       //接收到消息
//       historyMessage.add(obj);
//       print(historyMessage);
//       for (var i = 0; i < messageList.length; i++) {
//         if (messageList[i].userId != null) {
//           var count = 0;
//           for (var r = 0; r < historyMessage.length; r++) {
//             if (historyMessage[r]['status'] == 1 &&
//                 historyMessage[r]['bridge'].contains(messageList[i].userId) &&
//                 historyMessage[r]['uid'] != uid) {
//               count++;
//             }
//           }
//           if (count > 0) {
//             messageList[i].displayDot = true;
//             messageList[i].unreadMsgCount = count;
//           }
//         }
//         if (messageList[i].groupId != null) {
//           var count = 0;
//           for (var r = 0; r < historyMessage.length; r++) {
//             if (historyMessage[r]['status'] == 1 &&
//                 historyMessage[r]['groupId'] == messageList[i].groupId &&
//                 historyMessage[r]['uid'] != uid) {
//               count++;
//             }
//           }
//           if (count > 0) {
//             messageList[i].displayDot = true;
//             messageList[i].unreadMsgCount = count;
//           }
//         }
//       }
//     }
//     notifyListeners();
//   }

//   sendMessage(type, data, index) {
//     //发送消息
//     print(messageList[index].userId);
//     print(messageList[index].groupId);
//     var _bridge = [];
//     if (messageList[index].userId != null) {
//       _bridge
//         ..add(messageList[index].userId)
//         ..add(uid);
//     }
//     int _groupId;
//     if (messageList[index].groupId != null) {
//       _groupId = messageList[index].groupId;
//     }
//     print(_bridge);
//     var obj = {
//       "uid": uid,
//       "type": 2,
//       "nickname": nickname,
//       "msg": data,
//       "bridge": _bridge,
//       "groupId": _groupId
//     };
//     String text = json.encode(obj).toString();
//     print(text);
//     channel.sink.add(text);
//   }

//   onError(error) {
//     print('error------------>${error}');
//   }

//   void onDone() {
//     print('websocket断开了');
//     createWebsocket();
//     print('websocket重连');
//   }

//   closeWebSocket() {
//     //关闭链接
//     channel.sink.close();
//     print('关闭了websocket');
//     notifyListeners();
//   }
// }
