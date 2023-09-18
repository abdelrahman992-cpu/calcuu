import 'package:calculator/src/view/widget/setttingSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnCommit = void Function(String text);

//
class DeleteButton extends StatelessWidget {
  DeleteButton(this.onPressed, {Key? key}) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Semantics(
        label: 'Delete',
        child: const Icon(CupertinoIcons.delete),
      ),
      onPressed: onPressed,
    );
  }
}

//
class SettingButton extends StatelessWidget {
  SettingButton(this._onPressed, this._isIOS);
  final VoidCallback _onPressed;
  final bool _isIOS;
  @override
  Widget build(BuildContext context) {
    return _isIOS
        ? CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(CupertinoIcons.settings),
            onPressed: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return SettingSheet(_onPressed);
                  });
            },
          )
        : IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.settings),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SettingSheet(_onPressed);
                  });
            },
          );
  }
}

//

///إنشاء زر إدخال مناسب

Widget _buildTextButton(String label, OnCommit onPressed,
    {double width = 50.0}) {
  return LimitedBox(
    maxWidth: width,
    child: new TextButton(
      onPressed: () => onPressed(label),
      child: new Text(label, style: new TextStyle(fontSize: 14.0)),
    ),
  );
}

///قم بإنشاء شريط زر إدخال مناسب ينبثق بعد لوحة المفاتيح
Widget buildButtons(OnCommit onPressed) {
  return Column(children: <Widget>[
    Divider(
      color: CupertinoColors.black,
      height: 1.0,
    ),
    Divider(
      color: CupertinoColors.black,
      height: 1.0,
    ),
    LimitedBox(
      maxHeight: 40,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildTextButton(',', onPressed),
          _buildTextButton(';', onPressed),
          _buildTextButton(':', onPressed),
          _buildTextButton('[', onPressed),
          _buildTextButton('=', onPressed),
          _buildTextButton('(', onPressed),
        ],
      ),
    ),
    Divider(
      color: CupertinoColors.black,
      height: 1.0,
    ),
    LimitedBox(
      maxHeight: 40,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildTextButton('^', onPressed),
          _buildTextButton('+', onPressed),
          _buildTextButton('-', onPressed),
          _buildTextButton('*', onPressed),
          _buildTextButton('/', onPressed),
        ],
      ),
    ),
    Divider(
      color: CupertinoColors.black,
      height: 1.0,
    ),
  ]);
}
