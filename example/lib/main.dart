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
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final TextStyle display1 = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.normal);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${display1.fontFamily})',
              style: display1,
            ),
            Divider(),
            Text(
              '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${display1.fontFamily}, Bold)',
              style: display1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            DefaultTextStyle(
                style: NotoSansKR.getTextStyle(display1),
                child: Builder(
                  builder: (context) {
                    final defaultTextStyle = DefaultTextStyle.of(context).style;

                    return Column(
                      children: [
                        Text(
                          '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${defaultTextStyle.fontFamily})',
                        ),
                        Divider(),
                        Text(
                          '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${defaultTextStyle.fontFamily}, Bold)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                )),
            Divider(),
            DefaultTextStyle(
                style: NotoSansCJKKR.getTextStyle(display1),
                child: Builder(
                  builder: (context) {
                    final defaultTextStyle = DefaultTextStyle.of(context).style;

                    return Column(
                      children: [
                        Text(
                          '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${defaultTextStyle.fontFamily}, Thin)',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${defaultTextStyle.fontFamily}, Regular)',
                        ),
                        Divider(),
                        Text(
                          '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${defaultTextStyle.fontFamily}, Medium)',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(),
                        Text(
                          '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${defaultTextStyle.fontFamily}, Bold)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(),
                        Text(
                          '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${defaultTextStyle.fontFamily}, Black)',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    );
                  },
                )),
            Divider(),
            DefaultTextStyle(
                style: display1.copyWith(fontFamily: 'NotoSansCJKKRLocal'),
                child: Builder(
                  builder: (context) {
                    final defaultTextStyle = DefaultTextStyle.of(context).style;

                    return Column(
                      children: [
                        Text(
                          '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${defaultTextStyle.fontFamily}, Thin)',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${defaultTextStyle.fontFamily}, Regular)',
                        ),
                        Divider(),
                        Text(
                          '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${defaultTextStyle.fontFamily}, Medium)',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(),
                        Text(
                          '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${defaultTextStyle.fontFamily}, Bold)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(),
                        Text(
                          '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${defaultTextStyle.fontFamily}, Black)',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    );
                  },
                )),
            Divider(),
            Text(
                '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${NotoSansKR.getTextStyle(display1).fontFamily})',
                style: NotoSansKR.getTextStyle(display1)),
            Divider(),
            Text(
                '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${NotoSansKR.getTextStyle(display1).fontFamily}, Bold)',
                style: NotoSansKR.getTextStyle(display1.copyWith(
                  fontWeight: FontWeight.bold,
                ))),
            Divider(),
            Text(
                ' "oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${FiraCode.getTextStyle(display1).fontFamily})',
                style: FiraCode.getTextStyle(display1)),
            Divider(),
            Text(
              ' "oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (${FiraCode.getTextStyle(display1).fontFamily}, Bold)',
              style: FiraCode.getTextStyle(display1.copyWith(
                fontWeight: FontWeight.bold,
              )),
            ),
            Divider(),
            Column(
              children: [
                Text(
                  '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (Thin, NotoSansCJKKRLocal)',
                  style: TextStyle(
                    fontFamily: "NotoSansCJKKRLocal",
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (Thin, ${NotoSansCJKKR.fontFamily})',
                  style: TextStyle(
                    fontFamily: NotoSansCJKKR.fontFamily,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Divider(),
                Text(
                  '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (Regular, NotoSansCJKKRLocal)',
                  style: TextStyle(
                    fontFamily: "NotoSansCJKKRLocal",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (Regular, ${NotoSansCJKKR.fontFamily})',
                  style: TextStyle(
                    fontFamily: NotoSansCJKKR.fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Divider(),
                Text(
                  '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (Medium, NotoSansCJKKRLocal)',
                  style: TextStyle(
                    fontFamily: "NotoSansCJKKRLocal",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (Medium, ${NotoSansCJKKR.fontFamily})',
                  style: TextStyle(
                    fontFamily: NotoSansCJKKR.fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Divider(),
                Text(
                  '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (Bold, NotoSansCJKKRLocal)',
                  style: TextStyle(
                    fontFamily: "NotoSansCJKKRLocal",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (Bold, ${NotoSansCJKKR.fontFamily})',
                  style: TextStyle(
                    fontFamily: NotoSansCJKKR.fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Divider(),
                Text(
                  '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (Black, NotoSansCJKKRLocal)',
                  style: TextStyle(
                    fontFamily: "NotoSansCJKKRLocal",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '"oO08 iIlL1 g9qCGQ ~-+=>"; 한국어 (Black, ${NotoSansCJKKR.fontFamily})',
                  style: TextStyle(
                    fontFamily: NotoSansCJKKR.fontFamily,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
