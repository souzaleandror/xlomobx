import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlomobx/screens/base/base_screen.dart';
import 'package:xlomobx/stores/page_store.dart';
import 'package:xlomobx/stores/user_manager_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initalizedParse();
  setupLocators();
  runApp(MyApp());
}

Future<void> initalizedParse() async {
  await Parse().initialize('EhJMmxflE1sQa0YVlN8nMB11lRaUMufMopZdBamG',
      'https://parseapi.back4app.com/',
      clientKey: 'DUEsoLSIJ1r4k76uKSzMjMnobrlRGiOcj1kop2OF',
      autoSendSessionId: true,
      debug: true);
}

void setupLocators() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(UserManagerStore());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(elevation: 0),
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cursorColor: Colors.orange),
      home: BaseScreen(),
    );
  }
}
