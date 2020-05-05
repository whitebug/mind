import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mind/utils/utils.dart';

class MindAppBar extends StatelessWidget {
  final Function onBackPressed;
  final Function onMutePressed;
  final Function onSettingsPressed;
  final bool playerPage;
  const MindAppBar({
    Key key,
    @required this.onBackPressed,
    @required this.onMutePressed,
    @required this.onSettingsPressed,
    @required this.playerPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: onBackPressed,
        ),
        Row(
          children: <Widget>[
            Container(
              width: SizeConfig.safeBlockHorizontal * 10,
              height: SizeConfig.safeBlockHorizontal * 10,
              child: FlatButton(
                padding: const EdgeInsets.all(0),
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 5,
                  height: SizeConfig.safeBlockHorizontal * 5,
                  child: Image.asset('assets/design/audio.png'),
                ),
                onPressed: onMutePressed,
              ),
            ),
            Container(
              width: SizeConfig.safeBlockHorizontal * 12,
              height: SizeConfig.safeBlockHorizontal * 12,
              child: FlatButton(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 5,
                  height: SizeConfig.safeBlockHorizontal * 5,
                  child: Image.asset(
                    playerPage
                        ? 'assets/design/settings.png'
                        : 'assets/design/settings_on.png',
                  ),
                ),
                onPressed: onSettingsPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
