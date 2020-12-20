import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlomobx/screens/base/base_screen.dart';
import 'package:xlomobx/stores/category_store.dart';
import 'package:xlomobx/stores/home_store.dart';
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

  // final categories = await CategoryRepository().getList();
  // print(categories);

  // IBGERepository().getUFListFromApi().then((value) {
  //   print(value);
  //   IBGERepository()
  //       .getCityListFromApi(value.first)
  //       .then((value) => print(value));
  // });
  //
  // final address = await CepRepository().getAddressFromApi('05547-110');
  // print(address.toString());
}

void setupLocators() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(HomeStore());
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(CategoryStore());
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
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.orange,
        ),
      ),
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      home: BaseScreen(),
    );
  }
}
