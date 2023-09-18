import 'package:calculator/src/command/handleEquations.dart';
import 'package:calculator/src/data/settingData.dart';
import 'package:calculator/src/language/xiaomingLocalizations.dart';
import 'package:calculator/src/view/widget/myTextComposer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<Widget> _buildTips(BuildContext context) {
  return <Widget>[
    Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Text(XiaomingLocalizations.of(context).equationTip)),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(XiaomingLocalizations.of(context).equaHint1),
    ),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(XiaomingLocalizations.of(context).equaHint2),
    ),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(XiaomingLocalizations.of(context).equaHint3),
    ),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(XiaomingLocalizations.of(context).equaHint4),
    ),
    SizedBox(
      height: 20.0,
    ),
  ];
}

class EquationRoute extends StatefulWidget {
  EquationRoute({required Key key}) : super(key: key);
  @override
  _EquationRouteState createState() => _EquationRouteState();
}

class _EquationRouteState extends State<EquationRoute>
    with TickerProviderStateMixin {
  final TextEditingController _lineQuasController = TextEditingController();
  late AnimationController controller;
  late Animation<double> animation;
  String result = '';

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingData.nowPage = 0;

    List<Widget> widgets = <Widget>[
      MyTextField(
          _lineQuasController, XiaomingLocalizations.of(context).equations),
      CupertinoButton(
        color: Colors.blue,
        onPressed: () => _handleLineEquation(),
        child: Text(XiaomingLocalizations.of(context).calculate),
      ),
      Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: GestureDetector(
            onLongPress: () {
              Clipboard.setData(new ClipboardData(text: result));
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text(XiaomingLocalizations.of(context).copyHint),
                    );
                  });
            },
            child: Text(
              result,
              style: TextStyle(color: Colors.purple, fontSize: 20.0),
            ),
          ),
        ),
      ),
      FadeTransition(
        opacity: animation,
        child: CupertinoButton(
          child: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              result = "";
              controller.reverse();
            });
          },
        ),
      ),
    ];

    widgets.insertAll(0, _buildTips(context));

    ///主界面
    return DefaultTextStyle(
      ///指定默认文字格式
      style: const TextStyle(
        fontFamily: '.SF UI Text',
        inherit: false,
        fontSize: 17.0,
        color: CupertinoColors.black,
      ),
      child: Text("calcu"),
    );
  }

  void _handleLineEquation() {
    if (_lineQuasController.text.length != 0) {
      EquationsUtil handle = EquationsUtil.getInstance();
      var re = handle.handleEquation(_lineQuasController.text);
      setState(() {
        result = re;
      });
    } else {
      setState(() {
        result = XiaomingLocalizations.of(context).equationNotEmpty;
      });
    }
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
