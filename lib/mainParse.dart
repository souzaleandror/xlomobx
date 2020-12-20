import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  runApp(MyApp());

  await Parse().initialize('EhJMmxflE1sQa0YVlN8nMB11lRaUMufMopZdBamG',
      'https://parseapi.back4app.com/',
      clientKey: 'DUEsoLSIJ1r4k76uKSzMjMnobrlRGiOcj1kop2OF',
      autoSendSessionId: true,
      debug: true);

  final category = ParseObject('Categories')
    ..set<String>('Title', "camisetas")
    ..set<int>('Position', 2);
  final response = await category.save();
  print(response.success);

  final category2 = ParseObject('Categories')
    ..set<String>('Title', "Meias")
    ..set<int>('Position', 1);
  final response2 = await category2.save();
  print(response2.success);

  final category3 = ParseObject('Categories')
    ..objectId = 'k1NfQDGEl9'
    ..set<int>('Position', 3);
  final response3 = await category3.save();

  print(response3.success);

  final category4 = ParseObject('Categories')..objectId = 'UfFY9oGYcr';
  final response4 = await category4.delete();

  print(response4.success);

  final category5 = await ParseObject('Categories').getObject('k1NfQDGEl9');
  if (category5.success) {
    print(category5.result);
  }

  final response5 = await ParseObject('Categories').getAll();
  if (response5.success) {
    for (final object in response5.result) {
      print(object);
    }
  }

  final query = QueryBuilder(ParseObject('Categories'));

  query.whereEqualTo('Position', 2);
  final responseQuery = await query.query();

  if (responseQuery.success) {
    print(responseQuery.result);
  }

  final query2 = QueryBuilder(ParseObject('Categories'));

  query2.whereContains('Title', 'Blusas');

  final responseQuery2 = await query2.query();

  if (responseQuery2.success) {
    print(responseQuery2.result);
  }

  final query3 = QueryBuilder(ParseObject('Categories'));
  query3.whereContains('Title', 'Blusas');
  query3.whereEqualTo('Position', 2);

  final responseQuery3 = await query3.query();

  if (responseQuery3.success) {
    print(responseQuery3.result);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Container(),
    );
  }
}
