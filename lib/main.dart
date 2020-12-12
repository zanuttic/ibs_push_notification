import 'package:flutter/material.dart';
import 'package:ibs_push_notification/src/providers/push_notifications_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Push Notification'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
 
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    var mensaje="";
    
   @override
    void initState() { 
      super.initState();
      final pushProvider = new PushNotificationsProvider();
      pushProvider.initNotification();
      pushProvider.mensajesStream.listen((data) { 
        print('Body del mensaje: $data');
        mensaje= data;
        setState(() {
          
        });
      });
  
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hola, soy una app de notificaciones',
            ),
            Text(mensaje),
          ],
        ),
      ),
    );
  }
}
