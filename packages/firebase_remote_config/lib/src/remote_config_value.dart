part of firebase_remote_config;

/// ValueSource defines the possible sources of a config parameter value.
enum ValueSource { valueStatic, valueDefault, valueRemote }

/// RemoteConfigValue encapsulates the value and source of a Remote Config
/// parameter.
class RemoteConfigValue {
  dynamic _value;
  ValueSource _source;

  RemoteConfigValue._(this._value, this._source);

  ValueSource get source => _source == ValueSource.valueDefault
      ? ValueSource.valueDefault
      : ValueSource.valueRemote;

  /// Decode value to string.
  String asString() {
    return _value != null
        ? UTF8.decode(_value)
        : RemoteConfig.defaultValueForString;
  }

  /// Decode value to int.
  int asInt() {
    if (_value != null) {
      final String strValue = UTF8.decode(_value);
      final int intValue = int.parse(strValue,
          onError: (String source) => RemoteConfig.defaultValueForInt);
      return intValue;
    } else {
      return RemoteConfig.defaultValueForInt;
    }
  }

  /// Decode value to double.
  double asDouble() {
    if (_value != null) {
      final String strValue = UTF8.decode(_value);
      final double doubleValue = double.parse(
          strValue, (String source) => RemoteConfig.defaultValueForDouble);
      return doubleValue;
    } else {
      return RemoteConfig.defaultValueForDouble;
    }
  }

  /// Decode value to bool.
  bool asBool() {
    if (_value != null) {
      final String strValue = UTF8.decode(_value);
      return strValue.toLowerCase() == 'true';
    } else {
      return RemoteConfig.defaultValueForBool;
    }
  }
}
