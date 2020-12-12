import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajesStream=> _mensajesStreamController.stream;

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
    }
  }
  initNotification() async{
    await _firebaseMessaging.requestNotificationPermissions();
    final token= await _firebaseMessaging.getToken();

    print('Token: $token');

  _firebaseMessaging.configure(
        onMessage: onMessage,
        onBackgroundMessage: onBackgroundMessage,
        onLaunch: onLaunch,
        onResume: onResume
      );
  }
   Future<dynamic> onMessage(Map<String, dynamic> message) async {
    final titulo= message['notification']['title'];
    final body= message['notification']['body'];
    _mensajesStreamController.sink.add(body);

    print('========== onMessage===========');
    print('mensage: $message');
    print('titulo: $titulo');
    print('body: $body');
  }
   Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    
     final mensaje= message['data']['mensaje'];
    _mensajesStreamController.sink.add(mensaje);

    print('========== onResume===========');
    print('mensage: $mensaje');
  }
   Future<dynamic> onResume(Map<String, dynamic> message) async {
    
    
    final mensaje= message['data']['mensaje'];
    _mensajesStreamController.sink.add(mensaje);

    print('========== onResume===========');
    print('mensage: $mensaje');
  }
  dispose(){

    _mensajesStreamController?.close();
  }
}