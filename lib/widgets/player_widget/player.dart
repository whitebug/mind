import 'package:flutter/material.dart';
import 'package:mind/utils/size_config.dart';
import 'package:mind/widgets/widgets.dart';

class Player extends StatelessWidget {
  final String time;
  final double progress;

  const Player({
    Key key,
    @required this.time,
    @required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 60,
      height: SizeConfig.safeBlockHorizontal * 60,
      child: CustomPaint(
        foregroundPainter: PlayerCircle(
          mainColor: Colors.white38,
          progressColor: Colors.white,
          width: 2,
          progress: progress,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'day 1',
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                  color: Colors.transparent,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
              Text(
                'day 1',
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
