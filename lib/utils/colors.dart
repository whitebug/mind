import 'package:flutter/material.dart';

const eatMainColor = const Color(0xFF6D57C3);
const eatPurple = const Color(0xFFEE82EE);
const eatRed = const Color(0xFFFF1D1D);
const eatYellow = const Color(0xFFFDE910);
const eatYellowDarker = const Color(0xFFE8D616);
const eatOrange = const Color(0xFFFF5C00);
const eatGreen = const Color(0xFF77FC39);
const eatBlue = const Color(0xFF007AFF);

// buttons
const eatCalcButtonInactive = const Color(0xFFEE82EE);
const eatCalcButtonActive = const Color(0xFFFF99FF);

// shop buttons
const eatShowButtonGreen = const Color(0xFF62DA29);

// diagrams
const eatGreenDarker = const Color(0xFF4BBC15);
// appbar
const eatAppBarGreen = const Color(0xFF80CB82);
// buy button
const eatRedBuyButton = const Color(0xFFFF6C6C);
// vitamin title color
const eatVitaminTitle = const Color(0xFFFA9117);

// weight diagram
const eatDiagramDarkBlue = const Color(0xFF1361D7);
const eatDiagramBlue = const Color(0xFF5297FF);
const eatDiagramLightBlue = const Color(0xFF9BC3FF);
const eatDiagramGreen = const Color(0xFF4BBC15);
const eatDiagramYellow = const Color(0xFFFFCA62);
const eatDiagramOrange = const Color(0xFFFF9A62);
const eatDiagramRed = const Color(0xFFFF6262);
const eatDiagramDarkRed = const Color(0xFFFF3737);

// new design
// main buttons
const eatMainButtonGreen = const Color(0xFF80CB82);

List<Color> mapIndexColors = [
  eatDiagramDarkBlue,
  eatDiagramBlue,
  eatDiagramLightBlue,
  eatDiagramGreen,
  eatDiagramYellow,
  eatDiagramOrange,
  eatDiagramRed,
  eatDiagramDarkRed,
];

// gradients
final AlignmentGeometry _beginLeftAlignment = Alignment.bottomLeft;
final AlignmentGeometry _endLeftAlignment = Alignment.topRight;

final AlignmentGeometry _beginRightAlignment = Alignment.bottomRight;
final AlignmentGeometry _endRightAlignment = Alignment.topLeft;

LinearGradient buildGradient(AlignmentGeometry begin, AlignmentGeometry end,
        List<Color> colors, List<double> stops) =>
    LinearGradient(begin: begin, end: end, colors: colors, stops: stops);

LinearGradient eatGradientPurple = buildGradient(
    _beginLeftAlignment,
    _endLeftAlignment,
    const [Color(0xFF965796), Color(0xFFEE82EE), Color(0xFFEE82EE)],
    [0.0, 0.6, 1.0]);
LinearGradient eatGradientRed = buildGradient(
    _beginRightAlignment,
    _endRightAlignment,
    const [Color(0xFFB71313), Color(0xFFFF1D1D), Color(0xFFFF1D1D)],
    [0.0, 0.6, 1.0]);
LinearGradient eatGradientYellow = buildGradient(
    _beginLeftAlignment,
    _endLeftAlignment,
    const [Color(0xFFBAAB0B), Color(0xFFFDE910), Color(0xFFFDE910)],
    [0.0, 0.6, 1.0]);
LinearGradient eatGradientOrange = buildGradient(
    _beginRightAlignment,
    _endRightAlignment,
    const [Color(0xFFBC8011), Color(0xFFFF5C00), Color(0xFFFF5C00)],
    [0.0, 0.6, 1.0]);
LinearGradient eatGradientGreen = buildGradient(
    _beginLeftAlignment,
    _endLeftAlignment,
    const [Color(0xFF308B05), Color(0xFF77FC39), Color(0xFF77FC39)],
    [0.0, 0.6, 1.0]);
LinearGradient eatGradientBlue = buildGradient(
    _beginRightAlignment,
    _endRightAlignment,
    const [Color(0xFF04337A), Color(0xFF007AFF), Color(0xFF007AFF)],
    [0.0, 0.6, 1.0]);

// app bar
final AlignmentGeometry _beginAppBarAlignment = Alignment.bottomCenter;
final AlignmentGeometry _endAppBarAlignment = Alignment.topCenter;

LinearGradient eatAppBarGradientPurple = buildGradient(
    _beginAppBarAlignment,
    _endAppBarAlignment,
    const [Color(0xFF965796), Color(0xFFEE82EE), Color(0xFFEE82EE)],
    [0.0, 0.6, 1.0]);
LinearGradient eatAppBarGradientRed = buildGradient(
    _beginAppBarAlignment,
    _endAppBarAlignment,
    const [Color(0xFFB71313), Color(0xFFFF1D1D), Color(0xFFFF1D1D)],
    [0.0, 0.6, 1.0]);
LinearGradient eatAppBarGradientYellow = buildGradient(
    _beginAppBarAlignment,
    _endAppBarAlignment,
    const [Color(0xFFBAAB0B), Color(0xFFFDE910), Color(0xFFFDE910)],
    [0.0, 0.6, 1.0]);
LinearGradient eatAppBarGradientOrange = buildGradient(
    _beginAppBarAlignment,
    _endAppBarAlignment,
    const [Color(0xFFBC8011), Color(0xFFFF5C00), Color(0xFFFF5C00)],
    [0.0, 0.6, 1.0]);
LinearGradient eatAppBarGradientGreen = buildGradient(
    _beginAppBarAlignment,
    _endAppBarAlignment,
    const [Color(0xFF308B05), Color(0xFF77FC39), Color(0xFF77FC39)],
    [0.0, 0.6, 1.0]);
LinearGradient eatAppBarGradientBlue = buildGradient(
    _beginAppBarAlignment,
    _endAppBarAlignment,
    const [Color(0xFF04337A), Color(0xFF007AFF), Color(0xFF007AFF)],
    [0.0, 0.6, 1.0]);
