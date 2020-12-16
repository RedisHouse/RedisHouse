// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_page_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MainPageData extends MainPageData {
  @override
  final bool redisListOpen;
  @override
  final bool logOpen;
  @override
  final BuiltMap<String, ConnectionDetail> connectedRedisMap;

  factory _$MainPageData([void Function(MainPageDataBuilder) updates]) =>
      (new MainPageDataBuilder()..update(updates)).build();

  _$MainPageData._({this.redisListOpen, this.logOpen, this.connectedRedisMap})
      : super._();

  @override
  MainPageData rebuild(void Function(MainPageDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MainPageDataBuilder toBuilder() => new MainPageDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MainPageData &&
        redisListOpen == other.redisListOpen &&
        logOpen == other.logOpen &&
        connectedRedisMap == other.connectedRedisMap;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, redisListOpen.hashCode), logOpen.hashCode),
        connectedRedisMap.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MainPageData')
          ..add('redisListOpen', redisListOpen)
          ..add('logOpen', logOpen)
          ..add('connectedRedisMap', connectedRedisMap))
        .toString();
  }
}

class MainPageDataBuilder
    implements Builder<MainPageData, MainPageDataBuilder> {
  _$MainPageData _$v;

  bool _redisListOpen;
  bool get redisListOpen => _$this._redisListOpen;
  set redisListOpen(bool redisListOpen) =>
      _$this._redisListOpen = redisListOpen;

  bool _logOpen;
  bool get logOpen => _$this._logOpen;
  set logOpen(bool logOpen) => _$this._logOpen = logOpen;

  MapBuilder<String, ConnectionDetail> _connectedRedisMap;
  MapBuilder<String, ConnectionDetail> get connectedRedisMap =>
      _$this._connectedRedisMap ??= new MapBuilder<String, ConnectionDetail>();
  set connectedRedisMap(
          MapBuilder<String, ConnectionDetail> connectedRedisMap) =>
      _$this._connectedRedisMap = connectedRedisMap;

  MainPageDataBuilder();

  MainPageDataBuilder get _$this {
    if (_$v != null) {
      _redisListOpen = _$v.redisListOpen;
      _logOpen = _$v.logOpen;
      _connectedRedisMap = _$v.connectedRedisMap?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MainPageData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MainPageData;
  }

  @override
  void update(void Function(MainPageDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MainPageData build() {
    _$MainPageData _$result;
    try {
      _$result = _$v ??
          new _$MainPageData._(
              redisListOpen: redisListOpen,
              logOpen: logOpen,
              connectedRedisMap: _connectedRedisMap?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'connectedRedisMap';
        _connectedRedisMap?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MainPageData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ConnectionDetail extends ConnectionDetail {
  @override
  final int dbNum;
  @override
  final BuiltMap<String, int> dbKeyNumMap;

  factory _$ConnectionDetail(
          [void Function(ConnectionDetailBuilder) updates]) =>
      (new ConnectionDetailBuilder()..update(updates)).build();

  _$ConnectionDetail._({this.dbNum, this.dbKeyNumMap}) : super._();

  @override
  ConnectionDetail rebuild(void Function(ConnectionDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConnectionDetailBuilder toBuilder() =>
      new ConnectionDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConnectionDetail &&
        dbNum == other.dbNum &&
        dbKeyNumMap == other.dbKeyNumMap;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, dbNum.hashCode), dbKeyNumMap.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ConnectionDetail')
          ..add('dbNum', dbNum)
          ..add('dbKeyNumMap', dbKeyNumMap))
        .toString();
  }
}

class ConnectionDetailBuilder
    implements Builder<ConnectionDetail, ConnectionDetailBuilder> {
  _$ConnectionDetail _$v;

  int _dbNum;
  int get dbNum => _$this._dbNum;
  set dbNum(int dbNum) => _$this._dbNum = dbNum;

  MapBuilder<String, int> _dbKeyNumMap;
  MapBuilder<String, int> get dbKeyNumMap =>
      _$this._dbKeyNumMap ??= new MapBuilder<String, int>();
  set dbKeyNumMap(MapBuilder<String, int> dbKeyNumMap) =>
      _$this._dbKeyNumMap = dbKeyNumMap;

  ConnectionDetailBuilder();

  ConnectionDetailBuilder get _$this {
    if (_$v != null) {
      _dbNum = _$v.dbNum;
      _dbKeyNumMap = _$v.dbKeyNumMap?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConnectionDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ConnectionDetail;
  }

  @override
  void update(void Function(ConnectionDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ConnectionDetail build() {
    _$ConnectionDetail _$result;
    try {
      _$result = _$v ??
          new _$ConnectionDetail._(
              dbNum: dbNum, dbKeyNumMap: _dbKeyNumMap?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'dbKeyNumMap';
        _dbKeyNumMap?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ConnectionDetail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
