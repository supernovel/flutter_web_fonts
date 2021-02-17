import 'package:flutter/material.dart';
import 'package:web_fonts_example/fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    final TextStyle display1 = Theme.of(context).textTheme.headline4;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${display1.fontFamily})',
              style: display1,
            ),
            Divider(),
            Text(
                '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${NotoSansKR.getTextStyle(display1).fontFamily})',
                style: NotoSansKR.getTextStyle(display1)),
            Divider(),
            Text(
                ' "oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${FiraCode.getTextStyle(display1).fontFamily})',
                style: FiraCode.getTextStyle(display1))
          ],
        ),
      ),
    );
  }
}
