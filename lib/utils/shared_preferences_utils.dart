import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  /// save variable to shared preferences
  static setVariableToShared({
    Key key,
    @required String variable,
    @required String title,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(
        title, (variable != null && variable != '') ? variable : "");
  }

  /// get variable from shared variables
  static Future<String> getVariableFromShared({
    Key key,
    @required String title,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String result = preferences.getString(title);
    return result;
  }

  /// save int variables to shared preferences
  static setIntVariableToShared({
    Key key,
    @required int variable,
    @required String title,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(title, variable);
  }

  /// get int variable from shared variables
  static Future<int> getIntVariableFromShared({
    Key key,
    @required String title,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int result = preferences.getInt(title);
    return result;
  }

  /// save int variables to shared preferences
  static setDoubleVariableToShared(
      {Key key, @required double variable, @required String title}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setDouble(title, variable);
  }

  /// get int variable from shared variables
  static Future<double> getDoubleVariableFromShared({
    Key key,
    @required String title,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    double result = preferences.getDouble(title);
    return result;
  }

  /// save list of strings variables to shared preferences
  static setListStringVariableToShared({
    Key key,
    @required List<String> variables,
    @required String title,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(title, variables);
  }

  /// get list of strings variables from shared variables
  static Future<List<String>> getListStringVariableFromShared({
    Key key,
    @required String title,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(title);
  }
}
