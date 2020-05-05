import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mind/widgets/pix_slider/pix_slider.dart';
import 'custom_slider_thumb.dart';
import 'dart:ui' as ui;

class SliderWidget extends StatefulWidget {
  final double sliderHeight;
  final double sliderWidth;
  final double min;
  final double max;
  final fullWidth;
  final IconData icon;
  final Color iconColor;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Function(double, String) onChange;
  final String code;
  final double value;
  final double fontSizeIcon;

  SliderWidget({
    @required this.sliderHeight,
    @required this.sliderWidth,
    @required this.max,
    this.min = 0,
    this.fullWidth = false,
    @required this.icon,
    @required this.iconColor,
    @required this.activeTrackColor,
    @required this.inactiveTrackColor,
    @required this.onChange,
    @required this.code,
    @required this.value,
    @required this.fontSizeIcon,
  });

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _value = 0;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  Future<ui.Image> loadImage({@required String thumbImage}) async {
    ByteData data = await rootBundle.load(thumbImage);
    if (data == null) {
      print("data is null");
      return null;
    } else {
      var codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      var frame = await codec.getNextFrame();
      return frame.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    double thumbRadius = widget.sliderHeight * 0.5;
    // width of first gap
    double firstGap = thumbRadius / 7;
    // width of last gap
    double lastGap = thumbRadius / 2;
    // width of slider
    double finalWidth = widget.sliderWidth;

    return Row(
      children: <Widget>[
        Container(
          width: finalWidth,
          height: widget.sliderHeight,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: widget.activeTrackColor,
                      inactiveTrackColor: widget.inactiveTrackColor,
                      trackShape: CustomTrackShape(
                        currentPosition: _value,
                        max: widget.max.toDouble(),
                        min: widget.min.toDouble(),
                        thumbHeight: widget.sliderHeight,
                      ),
                      trackHeight: widget.sliderHeight,
                      thumbShape: CustomSliderThumb(
                        thumbRadius: thumbRadius,
                        icon: widget.icon,
                        iconColor: widget.iconColor,
                        min: widget.min,
                        max: widget.max,
                        fontSizeIcon: widget.fontSizeIcon,
                        color: Colors.white,
                      ),
                      overlayColor: Colors.white.withOpacity(.1),
                    ),
                    child: Slider(
                      value: _value,
                      min: widget.min,
                      max: widget.max,
                      onChangeEnd: (value) {
                        widget.onChange(value, widget.code);
                      },
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
