// ignore_for_file: empty_catches

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveState<T> {
  String _instanceId = "";
  String Function(T)? _toStr;
  T? Function(String)? _fromStr;
  T Function(Object)? _catchError;
  T? _value;
  final _stream = BehaviorSubject<T>();
  Stream<T> get stream => _stream.stream;

  Future<T> get value async {
    final saveStateModel = SaveStateRegister.get<T>(_instanceId);
    try {
      if (_value != null) {
        return _value!;
      }
      final SharedPreferences storage = await SharedPreferences.getInstance();
      final str = storage.getString(SaveStateRegister._getId<T>(_instanceId));
      if (str != null) {
        final e = (_fromStr?.call(str) ?? (saveStateModel!.fromStr.call(str)));
        if (e == null) {
          return (_catchError?.call("error")) ??
              saveStateModel!.catchError.call("error");
        } else {
          return e;
        }
      } else {
        return (_catchError?.call("error")) ??
            saveStateModel!.catchError.call("error");
      }
    } catch (e) {
      return (_catchError?.call("error")) ??
          saveStateModel!.catchError.call("error");
    }
  }

  SaveState({
    String instanceId = "INSTANCE_ID",
    T Function(Object)? catchError,
    T? Function(String)? fromStr,
    String Function(T)? toStr,
    T? initialValue,
  }) {
    _instanceId = instanceId;
    _catchError = catchError;
    _fromStr = fromStr;
    _toStr = toStr;
    if (initialValue == null) {
      _stream.addStream(value.asStream());
    } else {
      set = initialValue;
    }
  }

  set set(T e) {
    _value = e;
    _stream.add(e);
    _writeInMemory(e);
  }

  Future<void> _writeInMemory(T e) async {
    try {
      final saveStateModel = SaveStateRegister.get<T>(_instanceId);
      final SharedPreferences storage = await SharedPreferences.getInstance();
      await storage.setString(
        SaveStateRegister._getId<T>(_instanceId),
        _toStr?.call(e) ?? saveStateModel?.toStr.call(e) ?? '',
      );
    } catch (e) {}
  }

  Future<void> clearStorage() async {
    try {
      final SharedPreferences storage = await SharedPreferences.getInstance();
      await storage.clear();
    } catch (e) {}
  }
}

class SaveStateRegister {
  static void register<T>({
    String instanceId = "INSTANCE_ID",
    required T Function(Object) catchError,
    required T? Function(String) fromStr,
    required String Function(T) toStr,
  }) {
    _values.addAll({
      _getId<T>(instanceId): SaveStateModel<T>(
        instanceId: _getId<T>(instanceId),
        catchError: catchError,
        fromStr: fromStr,
        toStr: toStr,
      ),
    });
  }

  static final Map<String, SaveStateModel> _values = {};
  static void unregister<T>(String? instanceId) {
    _values.removeWhere((key, value) => key == _getId<T>(instanceId));
  }

  static String _getId<T>(String? instanceId) {
    return (instanceId ?? '') + T.runtimeType.toString();
  }

  static SaveStateModel<T>? get<T>(String? instanceId) {
    return _values[_getId<T>(instanceId)] as SaveStateModel<T>?;
  }
}

class SaveStateModel<T> {
  final String instanceId;
  final String Function(T) toStr;
  final T? Function(String) fromStr;
  final T Function(Object) catchError;
  SaveStateModel({
    this.instanceId = "INSTANCE_ID",
    required this.toStr,
    required this.fromStr,
    required this.catchError,
  });

  SaveStateModel<T> copyWith({
    String? instanceId,
    String Function(T)? toStr,
    T? Function(String)? fromStr,
    T Function(Object)? catchError,
  }) {
    return SaveStateModel<T>(
      instanceId: instanceId ?? this.instanceId,
      toStr: toStr ?? this.toStr,
      fromStr: fromStr ?? this.fromStr,
      catchError: catchError ?? this.catchError,
    );
  }
}
