import 'dart:math';
import 'dart:ui';

class SizeKeyConst {
  static const DEVICE_KEY = "device_size";
  static const ROUND_ANGLE_KEY = "round_angle_size";
  static const REGULAR_POLYGON_KEY = "regular_angle_size";
  static const CIRCLE_KEY = "circle custom painter";
  static const CIRCLE_TRIANGLE_KEY = "circle triangle painter";
  static const LOGO_KEY = "logo_page_size";
}

class SizeUtil {
  static Map<String, SizeUtil> _keyValues = Map();

  static initDesignSize() {
    getInstance(key: SizeKeyConst.ROUND_ANGLE_KEY).designSize =
        Size(500.0, 500.0);
    getInstance(key: SizeKeyConst.REGULAR_POLYGON_KEY).designSize =
        Size(500.0, 500.0);
    getInstance(key: SizeKeyConst.LOGO_KEY).designSize = Size(580, 648.0);
    getInstance(key: SizeKeyConst.CIRCLE_KEY).designSize = Size(500.0, 500.0);
    getInstance(key: SizeKeyConst.CIRCLE_TRIANGLE_KEY).designSize =
        Size(500.0, 500.0);
  }

  static SizeUtil getInstance({key = SizeKeyConst.DEVICE_KEY}) {
    if (_keyValues.containsKey(key)) {
      return _keyValues[key];
    } else {
      _keyValues[key] = SizeUtil();
      return _keyValues[key];
    }
  }

  Size _designSize;

  set designSize(Size size) {
    _designSize = size;
  }

  //logic size in device
  Size _logicalSize;

  //device pixel radio.

  get width => _logicalSize.width;

  get height => _logicalSize.height;

  set logicSize(Size size) => _logicalSize = size;

  //@param w is the design w;
  double getAxisX(double w) {
    return (w * width) / _designSize.width;
  }

// the y direction
  double getAxisY(double h) {
    return (h * height) / _designSize.height;
  }

  // diagonal direction value with design size s.
  double getAxisBoth(double s) {
    return s *
        sqrt((width * width + height * height) /
            (_designSize.width * _designSize.width +
                _designSize.height * _designSize.height));
  }
}
