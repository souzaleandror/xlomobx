import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlomobx/screens/base/base_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initalizedParse();
  runApp(MyApp());
}

Future<void> initalizedParse() async {
  await Parse().initialize(
      'EhJMmxflE1sQa0YVlN8nMB11lRaUMufMopZdBamG',
      'https://parseapi.back4app.com/',
      clientKey: 'DUEsoLSIJ1r4k76uKSzMjMnobrlRGiOcj1kop2OF',
      autoSendSessionId: true,
      debug: true);

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BaseScreen(),
    );
  }
}